<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Approve Leave Requests</title>
    </head>
    <body>
        <h2>Danh sách đơn nghỉ phép chờ phê duyệt</h2>

        <c:if test="${empty leaveRequests}">
            <p>Không có đơn nghỉ nào đang chờ xử lý.</p>
        </c:if>

        <table border="1" cellpadding="8">
            <tr>
                <th>ID</th>
                <th>Lý do</th>
                <th>Từ ngày</th>
                <th>Đến ngày</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
            <c:forEach var="lr" items="${leaveRequests}">
                <tr>
                    <td>${lr.id}</td>
                    <td>${lr.reason}</td>
                    <td>${lr.from}</td>
                    <td>${lr.to}</td>
                    <td>
                        <c:choose>
                            <c:when test="${lr.status == 0}">⏳ In Progress</c:when>
                            <c:when test="${lr.status == 1}">✅ Approved</c:when>
                            <c:when test="${lr.status == 2}">❌ Rejected</c:when>
                        </c:choose>
                    </td>
                    <td>
                        <form action="${pageContext.request.contextPath}/leaverequest/approve" method="post">
                            <input type="hidden" name="lrid" value="${lr.id}" />
                            <button type="submit" name="action" value="approve">✔ Approve</button>
                            <button type="submit" name="action" value="reject">✖ Reject</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <br>
        <a href="${pageContext.request.contextPath}/home">
            <button>Back to Home</button>
        </a>

    </body>
</html>
