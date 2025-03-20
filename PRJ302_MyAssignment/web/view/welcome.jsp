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
            <a href="${pageContext.request.contextPath}/leaverequest/list">List Leave Request</a><br/>
            
            <!-- Check if the user has permission to approve leave requests -->
            <c:if test="${sessionScope.canApprove}">
                <a href="${pageContext.request.contextPath}/leaverequest/approve">Approve Leave Request</a><br/>
            </c:if>
        </h2>
    </body>
</html>
