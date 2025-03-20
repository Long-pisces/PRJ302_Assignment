<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Leave Request</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: linear-gradient(to right, #2a5298, #1e3c72);
            color: #fff;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }

        .container {
            background: #f4f7fa;
            border-radius: 12px;
            padding: 30px 40px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.25);
            width: 100%;
            max-width: 500px;
            text-align: center;
        }

        .container h1 {
            font-size: 24px;
            color: #1e3c72;
            margin-bottom: 30px;
        }

        .menu a {
            display: block;
            text-decoration: none;
            color: #1e3c72;
            background-color: #e6ecf5;
            margin: 10px 0;
            padding: 12px 20px;
            border-radius: 8px;
            font-weight: 500;
            transition: 0.3s;
            font-size: 15px;
        }

        .menu a i {
            margin-right: 10px;
        }

        .menu a:hover {
            background-color: #c9d7f1;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Welcome, ${sessionScope.user.displayname}</h1>

        <div class="menu">
            <a href="${pageContext.request.contextPath}/leaverequest/create">
                <i class="fas fa-plus-circle"></i> Create Leave Request
            </a>
            <a href="${pageContext.request.contextPath}/leaverequest/update">
                <i class="fas fa-edit"></i> Update Leave Request
            </a>
            <a href="${pageContext.request.contextPath}/leaverequest/list">
                <i class="fas fa-list-ul"></i> List Leave Requests
            </a>
            <a href="${pageContext.request.contextPath}/leaverequest/approve">
                <i class="fas fa-check-circle"></i> Approve Leave Requests
            </a>
        </div>
    </div>

</body>
</html>
