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
</head>
<body>
    <h2>Update Leave Request</h2>
    
    <form action="${pageContext.request.contextPath}/leaverequest/update" method="post">
        <input type="hidden" name="lrid" value="<%= lr.getId() %>"/>
        
        Reason: <input type="text" name="reason" value="<%= lr.getReason() %>" required/><br/>
        
        From Date: <input type="date" name="from" value="<%= lr.getFrom() %>" required/><br/>
        
        To Date: <input type="date" name="to" value="<%= lr.getTo() %>" required/><br/>

        <!-- Update Button -->
        <button type="submit" name="action" value="update">Update</button>
        
        <!-- Delete Button -->
        <button type="submit" name="action" value="delete" onclick="return confirm('Are you sure you want to delete this leave request?');">Delete</button>
    </form>
</body>
</html>
