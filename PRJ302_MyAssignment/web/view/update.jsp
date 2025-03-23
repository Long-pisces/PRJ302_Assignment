<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.LeaveRequest"%>
<%@page import="model.User"%>
<%@page import="java.sql.Date"%>

<%
    LeaveRequest lr = (LeaveRequest) request.getAttribute("lr");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Leave Request</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            box-sizing: border-box;
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
            color: #1e3c72;
            margin-bottom: 25px;
        }

        label {
            font-weight: 500;
            color: #333;
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
        }

        input[type="date"],
        input[type="text"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        input:focus {
            border-color: #1e3c72;
            outline: none;
        }

        .btn-group {
            display: flex;
            gap: 10px;
            margin-top: 25px;
        }

        .btn {
            flex: 1;
            padding: 12px;
            font-size: 15px;
            font-weight: 500;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-update {
            background-color: #1e3c72;
            color: #fff;
        }

        .btn-update:hover {
            background-color: #16325c;
        }

        .btn-delete {
            background-color: #e74c3c;
            color: #fff;
        }

        .btn-delete:hover {
            background-color: #c0392b;
        }

        i {
            margin-right: 6px;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2><i class="fas fa-edit"></i> Update Leave Request</h2>

    <form action="${pageContext.request.contextPath}/leaverequest/update" method="post">
        <input type="hidden" name="lrid" value="<%= lr.getId() %>" />

        <label for="reason"><i class="fas fa-comment-dots"></i> Reason</label>
        <input type="text" name="reason" value="<%= lr.getReason() %>" required />

        <label for="from"><i class="fas fa-calendar-day"></i> From Date</label>
        <input type="date" name="from" value="<%= lr.getFrom() %>" required />

        <label for="to"><i class="fas fa-calendar-day"></i> To Date</label>
        <input type="date" name="to" value="<%= lr.getTo() %>" required />

        <div class="btn-group">
            <button type="submit" name="action" value="update" class="btn btn-update">
                <i class="fas fa-save"></i> Update
            </button>
            <button type="submit" name="action" value="delete" class="btn btn-delete"
                    onclick="return confirm('Are you sure you want to delete this leave request?');">
                <i class="fas fa-trash-alt"></i> Delete
            </button>
        </div>
    </form>
</div>

</body>
</html>
