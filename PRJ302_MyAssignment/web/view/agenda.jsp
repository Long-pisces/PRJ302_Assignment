<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Leave Agenda</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #000; padding: 8px; text-align: center; }
        .green { background-color: green; color: white; }
        .red { background-color: red; color: white; }
    </style>
</head>
<body>
<h2>Employee Leave Agenda</h2>

<form method="post" action="${pageContext.request.contextPath}/leaverequest/agenda">
    Start Date: <input type="date" name="start" required />
    End Date: <input type="date" name="end" required />
    <button type="submit">Update Agenda</button>
</form>

<c:if test="${not empty employees && not empty dates}">
    <br/>
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

<br/>
<a href="${pageContext.request.contextPath}/home"><button>Back to Home</button></a>

</body>
</html>
