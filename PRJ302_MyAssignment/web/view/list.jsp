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
    <title>Leave Request List</title>
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
            margin-bottom: 25px;
            color: #1e3c72;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
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
            padding: 6px 10px;
            border-radius: 6px;
            color: white;
            font-size: 13px;
            font-weight: 500;
            display: inline-block;
        }

        .status.inprogress {
            background-color: #f39c12;
        }

        .status.approved {
            background-color: #27ae60;
        }

        .status.rejected {
            background-color: #e74c3c;
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
    <h2><i class="fas fa-list-ul"></i> Leave Request List</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Reason</th>
            <th>From</th>
            <th>To</th>
            <th>Created By</th>
            <th>Status</th>
            <th>Processed By</th>
        </tr>
        <%
            if (list != null && !list.isEmpty()) {
                for (LeaveRequest lr : list) {
                    String statusClass = lr.getStatus() == 0 ? "inprogress" :
                                         lr.getStatus() == 1 ? "approved" : "rejected";
                    String statusText = lr.getStatus() == 0 ? "In Progress" :
                                        lr.getStatus() == 1 ? "Approved" : "Rejected";
        %>
        <tr>
            <td><%= lr.getId() %></td>
            <td><%= lr.getReason() %></td>
            <td><%= lr.getFrom() %></td>
            <td><%= lr.getTo() %></td>
            <td><%= lr.getCreatedBy() != null ? lr.getCreatedBy().getDisplayname() : "N/A" %></td>
            <td><span class="status <%= statusClass %>"><%= statusText %></span></td>
            <td><%= lr.getProcessedBy() != null ? lr.getProcessedBy() : "N/A" %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="7" class="no-data">There is no leave request available.</td>
        </tr>
        <% } %>
    </table>
</div>

</body>
</html>
