<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f4f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .registration-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 300px;
        }

        h2 {
            text-align: center;
            color: #608BC1;
        }

        .reg-contains {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 5px;
            color: #555;
        }

        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="number"],
        input[type="password"] {
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        button {
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #45a049;
        }

        a {
            text-align: center;
            margin-top: 10px;
            color: #007BFF;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
        h1{
        margin-left: 10%;
        text-align: center;
            color: red;
            font-size:25px;
           
        }
    </style>
</head>
<body>
    <div class="registration-container">
        <h2>Registration Form</h2>
        <form action="reg" method="POST">
            <div class="reg-contains">
                <label for="name">Name</label>
                <input name="name" type="text" id="name" required>

                <label for="email">Email</label>
                <input name="email" type="email" id="email" required>

                <label for="phone">Phone</label>
                <input name="phone" type="tel" id="phone" required>

                <label for="std">Std</label>
                <input name="std" type="number" id="std" required>

                <label for="pass">Password</label>
                <input name="pass" type="password" id="pass" required>

                <button type="submit">Register</button>

                <a href="Login.jsp">Login</a>
            </div>
        </form>
    </div>
</body>
</html>
