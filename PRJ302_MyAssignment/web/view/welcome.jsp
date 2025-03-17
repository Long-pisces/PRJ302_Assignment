<%-- 
    Document   : welcome
    Created on : Feb 22, 2025, 11:09:45 AM
    Author     : sonnt-local
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello ${sessionScope.user.displayname}</h1>
        <h2>
            <a href="${pageContext.request.contextPath}/leaverequest/create">Create Leave Request</a><br/>
            <a href="${pageContext.request.contextPath}/leaverequest/update">Update Leave Request</a><br/>
            <a href="view/list.jsp">List Leave Request</a><br/>
        </h2>
    </body>
</html>
