<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Approve Leave Requests</title>
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
            max-width: 1000px;
            margin: auto;
        }

        h2 {
            text-align: center;
            color: #1e3c72;
            margin-bottom: 25px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
            border-bottom: 1px solid #ccc;
            font-size: 14px;
        }

        th {
            background-color: #f4f7fa;
            font-weight: 600;
        }

        tr:hover {
            background-color: #f0f4ff;
        }

        .status {
            font-weight: 500;
        }

        .status.inprogress {
            color: #f39c12;
        }

        .status.approved {
            color: #27ae60;
        }

        .status.rejected {
            color: #e74c3c;
        }

        .btn {
            padding: 8px 14px;
            font-size: 13px;
            font-weight: 500;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin: 2px;
            transition: 0.3s;
        }

        .btn-approve {
            background-color: #27ae60;
            color: #fff;
        }

        .btn-approve:hover {
            background-color: #219150;
        }

        .btn-reject {
            background-color: #e74c3c;
            color: #fff;
        }

        .btn-reject:hover {
            background-color: #c0392b;
        }

        .btn-back {
            display: inline-block;
            padding: 10px 20px;
            background-color: #1e3c72;
            color: #fff;
            border-radius: 8px;
            text-decoration: none;
            text-align: center;
            margin-top: 10px;
        }

        .btn-back:hover {
            background-color: #16325c;
        }

        .no-data {
            text-align: center;
            color: #888;
            font-style: italic;
            padding: 20px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2><i class="fas fa-check-circle"></i> Leave Requests Pending Approval</h2>

    <c:if test="${empty leaveRequests}">
        <p class="no-data">There is no leave request that is in progress.</p>
    </c:if>

    <c:if test="${not empty leaveRequests}">
        <table>
            <tr>
                <th>ID</th>
                <th>Reason</th>
                <th>From</th>
                <th>To</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            <c:forEach var="lr" items="${leaveRequests}">
                <tr>
                    <td>${lr.id}</td>
                    <td>${lr.reason}</td>
                    <td>${lr.from}</td>
                    <td>${lr.to}</td>
                    <td>
                        <c:choose>
                            <c:when test="${lr.status == 0}">
                                <span class="status inprogress">⏳ In Progress</span>
                            </c:when>
                            <c:when test="${lr.status == 1}">
                                <span class="status approved">✅ Approved</span>
                            </c:when>
                            <c:when test="${lr.status == 2}">
                                <span class="status rejected">❌ Rejected</span>
                            </c:when>
                        </c:choose>
                    </td>
                    <td>
                        <form action="${pageContext.request.contextPath}/leaverequest/approve" method="post">
                            <input type="hidden" name="lrid" value="${lr.id}" />
                            <button type="submit" name="action" value="approve" class="btn btn-approve">
                                ✔ Approve
                            </button>
                            <button type="submit" name="action" value="reject" class="btn btn-reject">
                                ✖ Reject
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:if>

    <div style="text-align: center;">
        <a href="${pageContext.request.contextPath}/home" class="btn-back">
            <i class="fas fa-arrow-left"></i> Back to Home
        </a>
    </div>
</div>

</body>
</html>
