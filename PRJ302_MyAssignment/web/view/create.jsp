<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Leave Request</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }

        form {
            width: 400px;
            margin: auto;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 15px;
        }

        input, textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
        }

        button {
            margin-top: 20px;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            width: 100%;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }

    </style>
</head>
<body>
<h2>Create Leave Request</h2>
<form action="${pageContext.request.contextPath}/leaverequest/create" method="post">
    <label for="reason">Reason</label>
    <textarea name="reason" rows="4" required></textarea>

    <label for="from">From Date</label>
    <input type="date" name="from" required />

    <label for="to">To Date</label>
    <input type="date" name="to" required />

    <button type="submit">Submit</button>
</form>
</body>
</html>
