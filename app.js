const express = require("express");
const fs = require("fs");
const mysql = require("mysql");
const multer = require("multer");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const cookieParser = require("cookie-parser");
const { redirect } = require("express/lib/response");
require("dotenv").config();

const app = express();
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(express.static("static"));
app.set("view engine", "ejs");
app.use(cookieParser());

const connection = mysql.createConnection({
  host: "localhost",
  port:3306,
  user: "root",
  password: "",
  database: "eservice",
});

connection.connect();

function authenticate(cookies) {
  if (cookies && cookies.accessToken) {
    let token = cookies.accessToken;
    try {
      const user = jwt.verify(token, process.env.ACCESS_TOKEN_SECRET);
      return user;
    } catch (err) {
      return false;
    }
  } else {
    return false;
  }
}

// GET
let global;

app.get("/", (req, res) => {
  res.render("index", { user: authenticate(req.cookies) });
});

app.get("/login", (req, res) => {
  if (authenticate(req.cookies)) res.redirect("/");
  else res.render("login", { incorrect: false });
});

app.get("/homepage", (req, res) => {
  let user = authenticate(req.cookies);
  if (!user) {
    res.redirect("/login");
    return;
  }
  connection.query(`SELECT is_employee FROM users WHERE user_id=${user.user}`, (error, results, fields) => {
    if (error) throw error;
    if(results[0].is_employee) {
      res.redirect("/employee");
    }
    else {
      res.redirect("/customer");
    }
  });
});

app.get("/about", (req, res) => {
  res.render("about", { user: authenticate(req.cookies) });
});

app.get("/logout", (req, res) => {
  res.clearCookie('accessToken');
  res.redirect('/');
});

app.get("/signup-customer", (req, res) => {
  if (authenticate(req.cookies)) {
    res.redirect("/");
    return;
  }
  res.render("signup_customer", { emailTaken: false, passwordInvalid: false });
});

app.get("/signup-employee", (req, res) => {
  if (authenticate(req.cookies)) {
    res.redirect("/");
    return;
  }
  res.render("signup_employee", { emailTaken: false, passwordInvalid: false });
});

//render an ejs page

app.get("/categories", (req, res) => {
  let categories = [];
  connection.query(`SELECT * FROM categories`, (error, results, fields) => {
    results.forEach((result) => {
      let category = {
        id: result.category_id,
        name: result.name,
        image: result.image,
      };
      categories.push(category);
    });
    res.render("categories", { categories: categories, user: authenticate(req.cookies) });
  });
});

app.get('/browse-category', (req, res) => {
    if (req.query.q && req.query.q != "") {
        res.render('browse_category', {q: req.query.q, name: 'All', image: 'category_all.jpg', user: authenticate(req.cookies)});
        return;
    }
    if (!req.query.id || req.query.id == "all") {
        res.render('browse_category', {id: 'all', name: 'All', image: 'category_all.jpg', user: authenticate(req.cookies)});
        return;
    }
    connection.query(`SELECT * FROM categories WHERE category_id = ${connection.escape(req.query.id)}`, (error, results, fields) => {
        if (!results[0])
            res.redirect('/browse-category?id=all');
        else
            res.render('browse_category', {id: results[0].category_id, name: results[0].name, image: results[0].image, 
              user: authenticate(req.cookies)});
    });
});

app.get('/browse-category-services', (req, res) => {
    let index = parseInt(req.query.index);
    if (typeof index != 'number') index = 0;
    let services = [];
    let sql = `SELECT user_id, first_name, last_name, photo, service_id, description, tags, users.rate AS rating,
    services.rate AS rate, country, city, available
    FROM services JOIN users ON services.employee_id = users.user_id JOIN employees ON services.employee_id = employees.employee_id
    LEFT JOIN (
      SELECT employee_id, SUM(availablity) AS available FROM employee_timeslots GROUP BY employee_id
    ) AS slots ON services.employee_id = slots.employee_id
    `;
    if (req.query.q && req.query.q != "") {
        let q = connection.escape(req.query.q).replaceAll('\'', '');
        let qspaces = q.replaceAll('-', ' ');
        sql += `WHERE tags LIKE '%${q}%' OR description LIKE '%${qspaces}%'
        `;
    }
    else if (req.query.category && req.query.category != "" && req.query.category != "all") {
        sql += `WHERE category_id = ${connection.escape(req.query.category)}
        `;
    }
    sql += `LIMIT ${index}, 5`;
    connection.query(sql, (error, results, fields) => {
        if (!results) {
            res.json([]);
            return;
        }
        results.forEach(result => {
            let service = {
                id: result.user_id,
                serviceID: result.service_id,
                name: result.first_name + " " + result.last_name,
                image: result.photo,
                description: result.description,
                rating: result.rating,
                available: result.available > 0,
                tags: result.tags.split(" "),
                rate: result.rate,
                location: result.city + ", " + result.country
            };
            services.push(service);
        });
        res.json(services);
    });
    
});


app.get("/new-service", (req, res) => {
  let id = authenticate(req.cookies);
  if (!id) {
    res.redirect("/");
    return;
  }
  connection.query(
    `SELECT is_employee FROM users WHERE user_id = '${id.user}'`,
    (error, results, fields) => {
      if (!results || !results[0].is_employee) {
        res.redirect("/");
        return;
      }
      let categories = [];
      connection.query(
        `SELECT category_id, name FROM categories`,
        (error, results, fields) => {
          results.forEach((result) => {
            let category = {
              id: result.category_id,
              name: result.name,
            };
            categories.push(category);
          });
          res.render("new_service", { categories: categories });
        }
      );
    }
  );
});

app.get("/forgot", (req, res) => {
  if (authenticate(req.cookies)) res.redirect("/");
  else {
    if (req.cookies.forgotToken) res.render("forgot_change");
    else if (req.cookies.forgotUser) res.render("forgot_code");
    else res.render("forgot_email", { invalid: false });
  }
});

app.get("/chat", (req, res) => {
  let user = authenticate(req.cookies);
  if (!user) {
    res.redirect("/login");
    return;
  }
  connection.query(`
    SELECT first_name, last_name, photo, user_id FROM 
    (SELECT DISTINCT IF(from_id=${user.user}, to_id, from_id) AS contact FROM chat 
    WHERE from_id = ${user.user} OR to_id = ${user.user}) AS contacts
    JOIN users ON contacts.contact = users.user_id`,
    (error, results, fields) => {
      res.render("chat", {contacts: JSON.parse(JSON.stringify(results))});
    });
});

app.get("/loadchat", (req, res) => {
  let user = authenticate(req.cookies);
  if (!user) {
    res.redirect("/login");
    return;
  }
  connection.query(`
  SELECT message, from_id, datetime FROM chat 
  WHERE from_id = ${user.user} AND to_id = ${connection.escape(req.query.user)}
  OR from_id = ${connection.escape(req.query.user)} AND to_id = ${user.user}
  `, (error, results, fields) => {
    let messages = [];
    for (let i = 0; i < results.length; i++) {
      if (results[i].message.trim() == "") continue;
      let message = {
        body: results[i].message,
        mine: results[i].from_id == user.user,
        date: results[i].datetime.getDate() + "/" + (results[i].datetime.getMonth()+1) + "/" + results[i].datetime.getFullYear()
              + " at " + (results[i].datetime.getHours() > 12 ? results[i].datetime.getHours() - 12 : results[i].datetime.getHours())
              + ":" + (results[i].datetime.getMinutes() < 10 ? "0" : "") + results[i].datetime.getMinutes()
              + (results[i].datetime.getHours() > 12 ? " PM" : " AM")
      };
      messages.push(message);
    }
    res.json(messages);
  });
});

//POST

app.post("/login", (req, res) => {
  connection.query(
    `SELECT user_id, password FROM users WHERE email = ${connection.escape(
      req.body.email
    )}`,
    (error, results, fields) => {
      if (error) throw error;
      if (!results[0]) {
        res.render("login", { incorrect: true });
      } else {
        bcrypt.compare(
          req.body.password,
          results[0].password,
          (err, matches) => {
            if (!matches) {
              res.render("login", { incorrect: true });
            } else {
              const user = { user: results[0].user_id };
              const accessToken = jwt.sign(
                user,
                process.env.ACCESS_TOKEN_SECRET
              );
              res.cookie("accessToken", accessToken);
              res.redirect("/");
            }
          }
        );
      }
    }
  );
});

app.post("/signup", (req, res) => {
  let image, idcard;

  const fileStorage = multer.diskStorage({
    destination: (req, file, callback) => {
      if (file.fieldname == "photo") callback(null, "static/img/users");
      else callback(null, "static/pdf/employee_id");
    },

    filename: (req, file, callback) => {
      let split = file.originalname.split(".");
      let name = Date.now() + "." + split[split.length - 1];
      if (file.fieldname == "photo") image = name;
      else idcard = name;
      callback(null, name);
    },
  });

  const upload = multer({ storage: fileStorage }).fields([
    {
      name: "photo",
      maxCount: 1,
    },
    {
      name: "idcard",
      maxCount: 1,
    },
  ]);

  upload(req, res, (error) => {
    if (error) throw error;

    let isEmployee = req.body.isEmployee ? 1 : 0;

    connection.query(
      `SELECT user_id FROM users WHERE email = ${connection.escape(
        req.body.email
      )}`,
      (error, results, fields) => {
        if (error) throw error;
        if (results[0]) {
          if (isEmployee) {
            res.render("signup_employee", {
              emailTaken: true,
              passwordInvalid: false,
            });
            return;
          } else {
            res.render("signup_customer", {
              emailTaken: true,
              passwordInvalid: false,
            });
            return;
          }
        }

        bcrypt.hash(req.body.password, 8, (error, passwordHash) => {
          if (error) throw error;

          connection.query(
            `INSERT INTO users (is_employee, email, password, first_name, last_name, phone, gender, date_of_birth, photo)
            VALUES (
                '${isEmployee}',
                ${connection.escape(req.body.email)},
                '${passwordHash}',
                ${connection.escape(req.body.firstname)},
                ${connection.escape(req.body.lastname)},
                ${connection.escape(req.body.phone)},
                '${req.body.gender == "male" ? "m" : "f"}',
                ${connection.escape(req.body.dob)},
                '${image}'
            )`,
            (error, results, fields) => {
              if (error) throw error;

              if (isEmployee) {
                connection.query(
                  `SELECT user_id FROM users WHERE email = ${connection.escape(
                    req.body.email
                  )}`,
                  (error, results, fields) => {
                    if (error) throw error;
                    let userid = results[0].user_id;

                    connection.query(
                      `INSERT INTO employees (employee_id, country, city, idcard) VALUES (
                            '${userid}',
                            ${connection.escape(req.body.country)},
                            ${connection.escape(req.body.city)},
                            '${idcard}'
                        )`,
                      (error, results, fields) => {
                        if (error) throw error;
                        res.redirect("/login");
                      }
                    );
                  }
                );
              } else res.redirect("/login");
            }
          );
        });
      }
    );
  });
});

app.post("/new-service", (req, res) => {
  let user = authenticate(req.cookies);
  if (!user) {
    redirect("/");
    return;
  }
  connection.query(
    `INSERT INTO services (category_id, employee_id, tags, rate, description) VALUES (
        ${connection.escape(req.body.category)},
        '${user.user}',
        ${connection.escape(req.body.tags)},
        ${connection.escape(req.body.rate)},
        ${connection.escape(req.body.description)}
    )`,
    (error, results, fields) => {
      res.redirect("/categories");
    }
  );
});

app.post("/chat", (req, res) => {
  let user = authenticate(req.cookies);
  if (!user) {
    redirect("/");
    return;
  }
  connection.query(`SELECT user_id FROM users WHERE user_id = ${connection.escape(req.body.to)}`, (error, results, fields) => {
    if (!results[0]) return;
    connection.query(`INSERT INTO chat (message, from_id, to_id, datetime) VALUES (
      ${connection.escape(req.body.msgbody)},
      ${user.user},
      ${connection.escape(results[0].user_id)},
      ${connection.escape(new Date())}
    )`, (error, results, fields) => {
      res.send("");
    }); 

  });  
  
}); 

app.post("/forgot", (req, res) => {
  let step = req.body.step;
  switch (step) {
    case "1":
      connection.query(
        `SELECT user_id FROM users WHERE email = ${connection.escape(
          req.body.email
        )}`,
        (error, results, fields) => {
          if (error) throw error;
          if (!results[0]) {
            res.render("forgot_email", { invalid: true });
            return;
          }
          let id = results[0].user_id;
          let code = "";
          for (let i = 0; i < 6; i++) {
            let charcode = Math.floor(Math.random() * 36) + 48;
            if (charcode > 57) charcode += 7;
            code += String.fromCharCode(charcode);
          }
          let date = new Date();
          connection.query(
            `INSERT INTO forgot_codes (user_id, code, created) VALUES ('${id}', '${code}', ${connection.escape(
              date
            )})`,
            (error, results, fields) => {
              if (error) throw error;
            }
          );
          res.cookie("forgotUser", id, { maxAge: 10 * 60 * 1000 });
          res.cookie("forgotEmail", req.body.email, { maxAge: 10 * 60 * 1000 });
          res.render("forgot_code");
        }
      );
      break;
    case "2":
      let idCookie = req.cookies.forgotUser;
      let codeInput = req.body.code;
      connection.query(
        `SELECT code_id, created FROM forgot_codes WHERE user_id = ${connection.escape(
          idCookie
        )} AND code = ${connection.escape(codeInput)}`,
        (error, results, fields) => {
          if (error) throw error;
          if (!results[0]) {
            res.render("forgot_invalid", { email: req.cookies.forgotEmail });
          } else {
            let created = results[0].created;
            let now = new Date();
            connection.query(
              `DELETE FROM forgot_codes WHERE code_id = ${results[0].code_id}`,
              (err, results, fields) => {
                if (error) throw error;
              }
            );
            if ((now - created) / 1000 > 60 * 10) {
              res.render("forgot_invalid", { email: req.cookies.forgotEmail });
              return;
            } else {
              const user = { user_id: idCookie };
              const forgotToken = jwt.sign(
                user,
                process.env.ACCESS_TOKEN_SECRET
              );
              res.cookie("forgotToken", forgotToken, {
                maxAge: 10 * 60 * 1000,
              });
              res.render("forgot_change");
            }
          }
        }
      );
      break;
    case "3":
      let password = req.body.password;
      if (password.length < 8 || password.length > 30) {
        res.render("forgot_change");
      } else {
        let user;
        res.clearCookie("forgotUser");
        res.clearCookie("forgotEmail");
        res.clearCookie("forgotToken");
        try {
          user = jwt.verify(
            req.cookies.forgotToken,
            process.env.ACCESS_TOKEN_SECRET
          );
        } catch (error) {
          res.redirect("/");
          return;
        }

        bcrypt.hash(password, 8, (error, passwordHash) => {
          if (error) throw err;
          connection.query(
            `UPDATE users SET password = '${passwordHash}' WHERE user_id = '${user.user_id}'`,
            (err, results, fields) => {
              if (error) throw error;
            }
          );
          res.redirect("/login");
        });
      }
      break;
  }
});
let s_id;
// Fatima Code
let emp_id = 2;
let Vname = "Adam";
let from_id = 2; //from booking table
let to_id = 3;

let service_id = 0;
let eid;

connection.query("SELECT * FROM users", (error, results, fields) => {
  if (error) throw error;
});

app.get("/booking", (req, res) => {
    let user = authenticate(req.cookies);
  if (!user) {
    res.redirect("/login");
    return;
  }
  
    connection.query(`SELECT is_employee FROM users WHERE user_id=${user.user}`, (error, results, fields) => {
    if (error) throw error;
    if (results[0].is_employee ==1) {
      res.redirect("/");
      return;
    }

  let book = [];
  let Uname = [];
               s_id=req.query.service;
                     connection.query(
                       `SELECT employee_id as id_e from services WHERE service_id = ${req.query.service} `,
                       (error, results, fields) => {
                         if (error) throw error;
                         eid = results[0].id_e;
                         console.log("done");
                           connection.query(
                             `SELECT count(*) as S FROM employee_timeslots  WHERE availablity=1  AND employee_id=${eid}`,
                             (error, results, fields) => {
                               if (error) throw error;
                               let se = results[0].S;
                               console.log(se);
                               if (se == 0) {
                                 res.redirect("/");
                               } else {
                                 // res.render("Booking", { Uname: Uname, book: book });
                               
                               connection.query(
                                 `SELECT * FROM employee_timeslots WHERE availablity=1  AND employee_id=${eid}`,
                                 (error, results, fields) => {
                                   if (error) throw error;

                                   results.forEach((result) => {
                                     let data = {
                                       timeslot_id: result.timeslot_id,
                                       day: result.date,
                                       time_from: result.time_from,
                                       time_to: result.time_to,
                                       emp: result.employee_id,
                                     };
                                     book.push(data);
                                   });
                                   // data=results;

                                   connection.query(
                                     `SELECT * FROM users WHERE user_id =${book[0].emp}`,
                                     (error, results, fields) => {
                                       if (error) throw error;
                                       console.log(results[0]);
                                       results.forEach((result) => {
                                         let Tname = {
                                           first_name: result.first_name,
                                         };
                                         Uname.push(Tname);
                                       });
                                       res.render("Booking", {
                                         Uname: Uname,
                                         book: book,
                                       });
                                       // fname=results;
                                       // console.log(fname);
                                      
                                       if (!user) {
                                         redirect("/");
                                         return;
                                       }
                               //        let se = 0;
                                     }
                                   );
                                 }
                               );}

                             }
                           );
                   }
                 );
  console.log("the id");
  console.log(req.query.service);
});});
app.post("/booking", (req, res) => {
    let user = authenticate(req.cookies);
    if (!user) {
      redirect("/");
      return;
    }
  let booking_id = req.body.in;

  let timeslot = req.body.start;
  let date =req.body.date;

  console.log(date);
//    connection.query(
//      `SELECT employee_id as id_e from services WHERE service_id = ${req.query.service} `,
//      (error, results, fields) => {
//        if (error) throw error;
// the_id=results[0].id_e;
//        console.log("done");
// service_id = req.query.service;
       connection.query(
         `INSERT INTO bookings (service_id,customer_id,emp_id,timeslot,status,date_booked,Fdone) VALUES (${s_id},${user.user},${eid},${connection.escape(
           timeslot
         )},1,${connection.escape(date)},0)`,
         (error, results, fields) => {
           if (error) throw error;

           console.log("done");

           connection.query(
             `UPDATE employee_timeslots SET availablity ='0' WHERE employee_id = ${eid} AND timeslot_id=${booking_id}`,
             (error, results, fields) => {
               if (error) throw error;

               console.log("done");
             }
           );
         }
       );
  //    }
  //  );
  res.redirect("/Customer");
});

app.get("/Slots", (req, res) => {
    let user = authenticate(req.cookies);
    if (!user) {
      redirect("/");
      return;
    }
      connection.query(`SELECT is_employee FROM users WHERE user_id=${user.user}`, (error, results, fields) => {
    if (error) throw error;
    if (results[0].is_employee != 1) {
      res.redirect("/");
      return;
    }
  res.render("Slots");
});});

let inti = 400;
app.post("/Slots", (req, res) => {
      let user = authenticate(req.cookies);
      if (!user) {
        redirect("/");
        return;
      }
  console.log("Posted");

  console.log(inti);
  let date = req.body.date;
  let from = req.body.from;
  let to = req.body.to;
  let Uname = req.body.name;
  let psswd = req.body.pwd;

  connection.query(
    `INSERT INTO employee_timeslots (availablity,employee_id,date,time_from,time_to) VALUES (1,${connection.escape(
      user.user
    )},${connection.escape(date)},${connection.escape(
      from
    )},${connection.escape(to)})`,
    (error, results, fields) => {
      if (error) throw error;

      inti++;

      res.redirect("/Slots");
    }
  );
});

// name id and all loginin crediantials are taken from login page
app.get("/Employee", (req, res) => {
  let user = authenticate(req.cookies);
  if (!user) {
    res.redirect("/login");
    return;
  }
  connection.query(`SELECT is_employee FROM users WHERE user_id=${user.user}`, (error, results, fields) => {
    if (error) throw error;
    if (results[0].is_employee != 1) {
      res.redirect("/");
      return;
    }

    let feedback = [];
    let appointments = [];

    connection.query(
      `SELECT count(*) AS count FROM bookings WHERE emp_id = ${user.user} AND status=4`,
      (error, results, fields) => {
        if (error) throw error;
        tasks = results[0];
        // var tasks = Object.values(JSON.parse(JSON.stringify(taskNew)))
        console.log(tasks);

        connection.query(
          `SELECT count(*)*50 AS rev FROM bookings WHERE emp_id = ${user.user} AND status=4`,
          (error, results, fields) => {
            if (error) throw error;

            revenue = results[0];
            console.log(revenue);
          }
        );
         connection.query(
           `SELECT rate AS r FROM users WHERE user_id = ${user.user}`,
           (error, results, fields) => {
             if (error) throw error;

             rate = results[0];
             //console.log(revenue);
           }
         );
        connection.query(
          `SELECT * FROM feedback WHERE to_id = ${user.user}`,
          (error, results, fields) => {
            if (error) throw error;
            results.forEach((result) => {
              let _feedback = {
                name: result.name,
                description: result.description,
              };
              feedback.push(_feedback);
            });
            // feedback=results;
          }
        );

        connection.query(
          `SELECT * FROM bookings WHERE emp_id = ${user.user} AND status!=0`,
          (error, results, fields) => {
            if (error) throw error;
            results.forEach((result) => {
              let _appointments = {
                booking_id: result.booking_id,
                customer_id: result.customer_id,
                service_id: result.service_id,
                status: result.status,
              };
              appointments.push(_appointments);
            });
            // appointments=results;

            res.render("Employee", {
              tasks: tasks,
              revenue: revenue,
              feedback: feedback,
              appointments: appointments,
            });
          }
        );
      }
    );

  });
  
});

app.get("/Customer", (req, res) => {
  let user = authenticate(req.cookies);
  if (!user) {
    res.redirect("/login");
    return;
  }
  connection.query(`SELECT is_employee FROM users WHERE user_id=${user.user}`, (error, results, fields) => {
    if (error) throw error;
    if (results[0].is_employee == 1) {
      res.redirect("/");
      return;
    }
  
    let feedback = [];
    let appointments = [];
    let rate;
  
    connection.query(
      `SELECT count(*) AS count FROM bookings WHERE customer_id = ${user.user}`,
      (error, results, fields) => {
        if (error) throw error;
        tasks = results[0];
        // var tasks = Object.values(JSON.parse(JSON.stringify(taskNew)))
        console.log(tasks);

        connection.query(
          `SELECT count(*) AS rev FROM employees`,
          (error, results, fields) => {
            if (error) throw error;

            emps = results[0];
            //console.log(revenue);
          }
        );
          connection.query(
            `SELECT rate AS r FROM users WHERE user_id = ${user.user}`,
            (error, results, fields) => {
              if (error) throw error;

              rate = results[0];
              //console.log(revenue);
            }
          );
        connection.query(
          `SELECT * FROM feedback WHERE to_id = ${user.user}`,
          (error, results, fields) => {
            if (error) throw error;
            results.forEach((result) => {
              let _feedback = {
                name: result.name,
                description: result.description,
              };
              feedback.push(_feedback);
              console.log("Thee feedback");
              console.log(feedback);
            });
            // feedback=results;
          }
        );

        connection.query(
          `SELECT * FROM bookings WHERE customer_id = ${user.user}`,
          (error, results, fields) => {
            if (error) throw error;
            results.forEach((result) => {
              let _appointments = {
                booking_id: result.booking_id,
                customer_id: result.customer_id,
                service_id: result.service_id,
                status: result.status,
              };
            
              appointments.push(_appointments);
            });
            connection.query(
              `SELECT count(*) AS serv FROM categories`,
              (error, results, fields) => {
                if (error) throw error;
                services = results[0];

                res.render("Customer", {
                  tasks: tasks,
                  emps: emps,
                  feedback: feedback,
                  appointments: appointments,
                  services: services,
                  rate:rate
                });
              }
            );
            // appointments=results;
          }
        );
      }
    );

  });

});


app.get("/efeedback", (req, res) => {
      let user = authenticate(req.cookies);
      if (!user) {
        redirect("/");
        return;
      }

  res.render("Employee Feedback");
});
let feed = 1;
app.post("/efeedback", (req, res) => {
  let user = authenticate(req.cookies);
  if (!user) {
    redirect("/");
    return;
  }

  console.log("Posted");

  //console.log(inti);

  // console.log(description);
  // from id taken from login to is taken from booking table
  // is from customer always 0->false
  let i_val = req.body.input;
  let rate = parseInt(req.body.rate);
  console.log("the rate");
  console.log(rate);
  let stotal;
  let rating;
  connection.query(
    `SELECT count(*) AS total FROM feedback WHERE to_id = ${to_id}`,
    (error, results, fields) => {
      if (error) throw error;
      stotal = parseInt(2);
      console.log(stotal);
      connection.query(
        `SELECT rate AS rating FROM users WHERE user_id = ${to_id}`,
        (error, results, fields) => {
          if (error) throw error;
          rating = parseFloat(results[0].rating);
          console.log("user rate");

          console.log(rating);
          let new_rate =
            ((parseFloat(rating) * parseInt(stotal) + parseInt(rate)) /
              (parseInt(stotal + 1) * 5)) *
            5;
          console.log("New rate");
          console.log(new_rate);
          connection.query(
            `UPDATE users SET rate =${new_rate} WHERE user_id = ${to_id}`,
            (err, results, fields) => {
              if (error) throw error;
              console.log("taarget", to_id);

              connection.query(
                `INSERT INTO Feedback(is_from_customer,rating,description,from_id,to_id,service_id) VALUES (0,${connection.escape(
                  new_rate
                )},${connection.escape(i_val)},${connection.escape(
                  user.user
                )},${connection.escape(to_id)},${connection.escape(
                  service_id
                )})`,

                (error, results, fields) => {
                  connection.query(
                    `UPDATE bookings SET Fdone ='2' WHERE customer_id = ${to_id} and service_id=${service_id}`,
                    (err, results, fields) => {
                      if (error) throw error;

                      res.redirect("/Employee");
                    }
                  );
                }
              );
            }
          );
        }
      );
    }
  );
});
app.post("/customerfeedback", (req, res) => {
      let user = authenticate(req.cookies);
      if (!user) {
        redirect("/");
        return;
      }
  res.render("Customer Feedback");
});
app.post("/addSlot", (req, res) => {
        let user = authenticate(req.cookies);
        if (!user) {
          redirect("/");
          return;
        }
  res.render("Slots");
});
app.post("/newfeedback", (req, res) => {
        let user = authenticate(req.cookies);
        if (!user) {
          redirect("/");
          return;
        }
  res.render("Employee Feedback");
});

app.get("/cfeedback", (req, res) => {
   console.log(to_id);
   console.log(service_id);
        let user = authenticate(req.cookies);
        if (!user) {
          redirect("/");
          return;
        }
    let id = authenticate(req.cookies);
    if (!id) {
      res.redirect("/");
      return;
    } 
  res.render("Customer Feedback");
});

app.post("/cfeedback", (req, res) => {
  let user = authenticate(req.cookies);
  if (!user) {
    redirect("/");
    return;
  }
  console.log("Posted");

  //console.log(inti);

  // console.log(description);
  // from id taken from login to is taken from booking table
  // is from customer always 0->false
  let i_val = req.body.input;
  let rate = parseInt(req.body.rate);
  console.log("the rate");
  console.log(rate);
  let stotal;
  let rating;
  connection.query(
    `SELECT count(*) AS total FROM feedback WHERE to_id = ${to_id}`,
    (error, results, fields) => {
      if (error) throw error;
      stotal = parseInt(2);
       console.log(stotal);
  connection.query(
    `SELECT rate AS rating FROM users WHERE user_id = ${to_id}`,
    (error, results, fields) => {
      if (error) throw error;
     rating = parseFloat(results[0].rating);
     console.log("user rate");

       console.log(rating);
       let new_rate=(((parseFloat(rating)*parseInt(stotal))+ parseInt(rate))/(parseInt((stotal+1))*5))*5;
       console.log("New rate");
       console.log(new_rate);
connection.query(
            `UPDATE users SET rate =${new_rate} WHERE user_id = ${to_id}`,
            (err, results, fields) => {
              if (error) throw error;
      connection.query(
        `INSERT INTO Feedback(is_from_customer,description,from_id,to_id,service_id,name,rating) VALUES (1,${connection.escape(
          i_val
        )},${connection.escape(user.user)},${connection.escape(
          to_id
        )},${connection.escape(
          service_id
        )},"fatima",${connection.escape(rate)})`,
        (error, results, fields) => {
          if (error) throw error;
          // feed++;
          console.log("feed is insertes",results);

          connection.query(
            `UPDATE bookings SET Fdone ='1' WHERE emp_id = ${to_id} and service_id=${service_id}`,
            (err, results, fields) => {
              if (error) throw error;

              res.redirect("/Customer");
            }
          );
        }
      );
    }
  );
});
});
});

app.post("/clist", (req, res) => {
  let user = authenticate(req.cookies);
  if (!user) {
    redirect("/");
    return;
  }
  let id = authenticate(req.cookies);
  if (!id) {
    res.redirect("/");
    return;

  }

  to_id=req.body.toid;
  service_id=req.body.serviceid;
  res.redirect("/cfeedback");
  
});

app.post("/list", (req, res) => {

 res.redirect("/list");
})


app.get("/list", (req, res) => {
  let user = authenticate(req.cookies);
  if (!user) {
    redirect("/");
    return;
  }
  let id = authenticate(req.cookies);
  if (!id) {
    res.redirect("/");
    return;
  }
  let feedlist = [];
  connection.query(
    `SELECT * FROM bookings WHERE customer_id = ${user.user} AND status=4 AND Fdone!=1`,
    (error, results, fields) => {
      if (error) throw error;
      results.forEach((result) => {
        let _appointments = {
          booking_id: result.booking_id,
          emp_id: result.emp_id,
          service_id: result.service_id,
        };
        feedlist.push(_appointments);
      });
      // appointments=results;

      res.render("feedbacklist", {
        feedlist: feedlist,
      });
    }
  );
  // res.render("feedbacklist");
});


app.get("/elist", (req, res) => {
  let user = authenticate(req.cookies);
  if (!user) {
    redirect("/");
    return;
  }
  let id = authenticate(req.cookies);
  if (!id) {
    res.redirect("/");
    return;
  }
  let feedlist = [];
  connection.query(

    `SELECT * FROM bookings WHERE emp_id = ${user.user} AND status=4 AND Fdone!=2`,
    (error, results, fields) => {
      if (error) throw error;
      results.forEach((result) => {
        let _appointments = {
          booking_id: result.booking_id,
          emp_id: result.customer_id,
          service_id: result.service_id,
        };
        feedlist.push(_appointments);
      });
      // appointments=results;

      res.render("efeedbacklist", {
        feedlist: feedlist,
      });
    }
  );
  // res.render("feedbacklist");
});


app.post("/elist", (req, res) => {
  let user = authenticate(req.cookies);
  if (!user) {
    redirect("/");
    return;
  }
  let id = authenticate(req.cookies);
  if (!id) {
    res.redirect("/");
    return;
  }

  to_id = req.body.toid;
  service_id = req.body.serviceid;
  res.redirect("/efeedback");
});


app.post("/list2", (req, res) => {
  res.redirect("/elist");
});
app.post("/reject", (req, res) => {
  let bid = req.body.bid;
   let sid = req.body.sid;
     connection.query(
       `UPDATE employee_timeslots SET availablity ='0' WHERE timeslot_id = ${bid} `,
       (error, results, fields) => {
         if (error) throw error;

          connection.query(
       `UPDATE bookings SET status ='0' WHERE service_id = ${sid} `,
       (error, results, fields) => {
         if (error) throw error;
         console.log("done");
         res.redirect("/Employee");
       }
     );
  
      });
});
app.post("/accept", (req, res) => {

  let sid = req.body.sid;
 

      connection.query(
        `UPDATE bookings SET status ='2' WHERE service_id = ${sid} `,
        (error, results, fields) => {
          if (error) throw error;
          console.log("done");
          res.redirect("/Employee");
        }
      );
    }
  );

  app.post("/Done", (req, res) => {
    let sid = req.body.sid;

    connection.query(
      `UPDATE bookings SET status ='4' WHERE service_id = ${sid} `,
      (error, results, fields) => {
        if (error) throw error;
        console.log("done");
        // connection.query(
      // `Delete FROM bookings WHERE service_id = ${sid} `,
      // (error, results, fields) => {
      //   if (error) throw error;
        res.redirect("/Employee");
      }
    );
  // });
});
// server

const server = app.listen(8081, () => {
  console.log("server is running");
});
