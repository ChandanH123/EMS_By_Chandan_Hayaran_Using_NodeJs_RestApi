let express = require('express');
let app = express();
let bodyParser = require('body-parser');
let mysql = require('mysql');

const port = process.env.PORT || 8080;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

//connect mysql database
let conn = mysql.createConnection({
    host : 'localhost',
    user: 'root',
    password: '',
    database: 'ems'
})

conn.connect();

app.get('/', (req, res) => {
    return res.json({
        error: false,
        message: 'Welcome to RESTfull api with node js for EMS.'
    });
})

app.get('/getAllEmployees', (req, res) => {
    conn.query("SELECT * FROM employees", (error, results) => {
        if (error) throw error;

        let message = ""
        if (results === undefined || results.length == 0) {
            message = "employees table is empty.";
            
            return res
            .status(400)
            .json({
                error: true,
                message: message,
                data: []
            });
        } else {
            message = "Successfully retrived all employees.";
            return res
            .status(200)
            .json({
                error: false,
                message: message,
                data: results
            });
        }

        
    })
})

app.post('/createEmployee', (req, res) => {
    let emp_firstName = req.body.emp_firstName;
    let emp_lastName = req.body.emp_lastName;
    let emp_contactNumber = req.body.emp_contactNumber
    let emp_gender = req.body.emp_gender
    //check validation
    if (!emp_firstName || !emp_lastName || !emp_contactNumber || !emp_gender) {
        return res
        .status(400)
        .json({
            error: true,
            message: "Please provide employee's firstName, lastName, contactNumber and gender.",
            data: []
        });
    } else {
        let values = [emp_firstName, emp_lastName, emp_contactNumber, emp_gender];
        conn.query('INSERT INTO employees (emp_firstName, emp_lastName, emp_contactNumber, emp_gender) VALUES(?, ?, ?, ?)', values, (error, results, fields) => {
            if (error) throw error;
            return res
            .status(200)
            .json({
                error: false,
                message: 'Employee successfully added.',
                data: []
            })
        });
    }
})

app.put('/updateEmployee', (req, res) => {
    let emp_id = req.body.emp_id;
    let emp_firstName = req.body.emp_firstName;
    let emp_lastName = req.body.emp_lastName;
    let emp_contactNumber = req.body.emp_contactNumber
    let emp_gender = req.body.emp_gender
    //check validation
    if (!emp_id || !emp_firstName || !emp_lastName || !emp_contactNumber || !emp_gender) {
        return res
        .status(400)
        .json({
            error: true,
            message: "Please provide employee's id, firstName, lastName, contactNumber and gender.",
            data: []
        });
    } else {
        let values = [emp_firstName, emp_lastName, emp_contactNumber, emp_gender, emp_id];
        conn.query('UPDATE employees SET emp_firstName = ?, emp_lastName = ?, emp_contactNumber = ?, emp_gender = ? WHERE emp_id = ?', values, (error, results, fields) => {
            if (error) throw error;

            let message = ""
            if (results.changedRows === 0) {
                message = "Employee not found or data are same."
                return res
                .status(400)
                .json({
                    error: true,
                    message: message,
                    data: []
                })
            } else {
                message = "Employee successfully updated."
                return res
                .status(200)
                .json({
                    error: false,
                    message: message,
                    data: []
                })
            }

            
        });
    }
})

app.delete('/deleteEmployee', (req, res) => {
    let emp_id = req.body.emp_id;

    //check validation
    if (!emp_id) {
        return res
        .status(400)
        .json({
            error: true,
            message: "Please provide employee id!",
            data: []
        });

    } else {
        let values = [emp_id];
        conn.query('DELETE FROM employees WHERE emp_id = ?', values, (error, results, fields) => {
            if (error) throw error;

            let message = "";

            if (results.affectedRows === 0) {
                message = "Employee not found!";
                return res
                .status(400)
                .json({
                    error: true,
                    message: message,
                    data: []
                })
            } else {
                message = "Employee successfully deleted.";
                return res
                .status(200)
                .json({
                    error: false,
                    message: message,
                    data: []
                })
            }

            
        });
    }
})



app.listen(port, () => {
    console.log("Listening on port %d", port);
})

module.exports = app;
