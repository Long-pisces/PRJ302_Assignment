<%@page import="java.util.ArrayList"%>
<%@page import="model.LeaveRequest"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ArrayList<LeaveRequest> list = (ArrayList<LeaveRequest>) request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách đơn nghỉ phép</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
        }
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #999;
            padding: 8px 12px;
            text-align: center;
        }
        th {
            background-color: #eee;
        }
        h2 {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <h2>List Of Leave Request</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Reason</th>
            <th>From Date</th>
            <th>To Date</th>
            <th>Created By</th>
            <th>Status</th>
            <th>Processed By</th>
        </tr>
        <%
            if (list != null && !list.isEmpty()) {
                for (LeaveRequest lr : list) {
        %>
        <tr>
            <td><%= lr.getId() %></td>
            <td><%= lr.getReason() %></td>
            <td><%= lr.getFrom() %></td>
            <td><%= lr.getTo() %></td>
            <td><%= lr.getCreatedBy() != null ? lr.getCreatedBy().getDisplayname() : "N/A" %></td>
            <td>
                <%= (lr.getStatus() == 0 ? "In Progress" : (lr.getStatus() == 1 ? "Approved" : "Rejected")) %>
            </td>
            <td><%= lr.getProcessedBy() != null ? lr.getProcessedBy() : "N/A" %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="7">There is no leave requests.</td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>
