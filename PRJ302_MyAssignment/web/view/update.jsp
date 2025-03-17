<%-- 
    Document   : update
    Created on : Mar 12, 2025, 12:53:01 AM
    Author     : Admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.LeaveRequest"%>
<%
    LeaveRequest lr = (LeaveRequest) request.getAttribute("lr");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Leave Request</title>
</head>
<body>
    <h2>Update Leave Request</h2>
    <form action="${pageContext.request.contextPath}/leaverequest/update" method="post">
        <input type="hidden" name="lrid" value="<%= lr.getId() %>"/>
        Reason: <input type="text" name="reason" value="<%= lr.getReason() %>" required/><br/>
        From Date: <input type="date" name="from" value="<%= lr.getFrom() %>" required/><br/>
        To Date: <input type="date" name="to" value="<%= lr.getTo() %>" required/><br/>
        <button type="submit">Update</button>
    </form>
</body>
</html>
