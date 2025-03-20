<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Leave Request</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: linear-gradient(to right, #1e3c72, #2a5298);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            padding: 20px;
        }

        .form-container {
            background-color: #f4f7fa;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.25);
            width: 100%;
            max-width: 500px;
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #1e3c72;
        }

        label {
            font-weight: 500;
            color: #333;
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
        }

        input[type="date"],
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        input[type="date"]:focus,
        textarea:focus {
            border-color: #1e3c72;
            outline: none;
        }

        button {
            margin-top: 25px;
            width: 100%;
            padding: 12px;
            background-color: #1e3c72;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.3s;
        }

        button:hover {
            background-color: #16325c;
        }

        .form-container i {
            margin-right: 8px;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2><i class="fas fa-calendar-plus"></i> Create Leave Request</h2>
    <form action="${pageContext.request.contextPath}/leaverequest/create" method="post">
        <label for="reason"><i class="fas fa-comment-dots"></i> Reason</label>
        <textarea name="reason" rows="4" required placeholder="Enter your reason..."></textarea>

        <label for="from"><i class="fas fa-calendar-day"></i> From Date</label>
        <input type="date" name="from" required />

        <label for="to"><i class="fas fa-calendar-day"></i> To Date</label>
        <input type="date" name="to" required />

        <button type="submit"><i class="fas fa-paper-plane"></i> Submit</button>
    </form>
</div>

</body>
</html>
