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
            <a href="view/create.jsp">Create Form</a><br/>
            <a href="view/list.jsp">List Form</a><br/>
            <a href="view/update.jsp">Update Form</a><br/>
        </h2>
    </body>
</html>
