<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Leave Agenda</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: linear-gradient(to right, #1e3c72, #2a5298);
            color: #333;
            padding: 40px;
        }

        .container {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            max-width: 1100px;
            margin: auto;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #1e3c72;
        }

        form {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }

        input[type="date"] {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        button {
            background-color: #1e3c72;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
            transition: background 0.3s;
        }

        button:hover {
            background-color: #16325c;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
            font-size: 13px;
        }

        th {
            background-color: #f4f7fa;
            font-weight: 600;
        }

        .green {
            background-color: #27ae60;
            color: white;
        }

        .red {
            background-color: #e74c3c;
            color: white;
        }

        .back-btn {
            margin-top: 30px;
            text-align: center;
        }

        .back-btn a button {
            background-color: #888;
        }

        .back-btn a button:hover {
            background-color: #555;
        }
    </style>
</head>
<body>

<div class="container">
    <h2><i class="fas fa-calendar-alt"></i> Employee Leave Agenda</h2>

    <form method="post" action="${pageContext.request.contextPath}/leaverequest/agenda">
        <input type="date" name="start" required />
        <input type="date" name="end" required />
        <button type="submit"><i class="fas fa-search"></i> Show Agenda</button>
    </form>

    <c:if test="${not empty employees && not empty dates}">
        <table>
            <thead>
            <tr>
                <th>Employee</th>
                <c:forEach var="date" items="${dates}">
                    <th><c:out value="${date.dayOfMonth}/${date.monthValue}"/></th>
                </c:forEach>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="emp" items="${employees}">
                <tr>
                    <td><c:out value="${emp.name}"/></td>
                    <c:forEach var="date" items="${dates}">
                        <c:set var="isLeave" value="${leaveMap[emp.id] != null && leaveMap[emp.id].contains(date)}"/>
                        <td class="${isLeave ? 'red' : 'green'}">
                            ${isLeave ? '✘' : '✔'}
                        </td>
                    </c:forEach>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>

    <div class="back-btn">
        <a href="${pageContext.request.contextPath}/home">
            <button><i class="fas fa-arrow-left"></i> Back to Home</button>
        </a>
    </div>
</div>

</body>
</html>
