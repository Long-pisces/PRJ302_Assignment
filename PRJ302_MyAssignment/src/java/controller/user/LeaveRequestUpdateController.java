package controller.user;

import controller.authentication.BaseRequiredAuthenticationController;
import dal.LeaveRequestDBContext;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.sql.Date;
import model.LeaveRequest;
import model.User;

@WebServlet(name = "LeaveRequestUpdateController", urlPatterns = {"/leaverequest/update"})
public class LeaveRequestUpdateController extends BaseRequiredAuthenticationController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {

        if (!hasAccess(user, req.getServletPath())) {
            resp.setContentType("text/html;charset=UTF-8");
            resp.getWriter().println("<h2 style='color:red;'>Bạn không có quyền truy cập chức năng này.</h2>");
            return;
        }

        LeaveRequestDBContext db = new LeaveRequestDBContext();
        int latestId = -1;

        try {
            String sql = "SELECT TOP 1 lrid FROM LeaveRequests WHERE createdby = ? ORDER BY createddate DESC";
            PreparedStatement stm = db.getConnection().prepareStatement(sql);
            stm.setString(1, user.getUsername());
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                latestId = rs.getInt("lrid");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (latestId != -1) {
            LeaveRequest lr = db.get(latestId);
            req.setAttribute("lr", lr);
            req.getRequestDispatcher("/view/update.jsp").forward(req, resp);
        } else {
            resp.setContentType("text/html;charset=UTF-8");
            resp.getWriter().println("<h2 style='color:red;'>You have no leave request to update.</h2>");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {

        if (!hasAccess(user, req.getServletPath())) {
            resp.setContentType("text/html;charset=UTF-8");
            resp.getWriter().println("<h2 style='color:red;'>Bạn không có quyền truy cập chức năng này.</h2>");
            return;
        }

        int lrid = Integer.parseInt(req.getParameter("lrid"));
        String action = req.getParameter("action");

        LeaveRequestDBContext db = new LeaveRequestDBContext();

        if ("delete".equals(action)) {
            LeaveRequest lr = new LeaveRequest();
            lr.setId(lrid);
            db.delete(lr);
            resp.sendRedirect("../home");
        } else {
            String reason = req.getParameter("reason");
            Date from = Date.valueOf(req.getParameter("from"));
            Date to = Date.valueOf(req.getParameter("to"));

            LeaveRequest lr = new LeaveRequest();
            lr.setId(lrid);
            lr.setReason(reason);
            lr.setFrom(from);
            lr.setTo(to);

            db.update(lr);
            resp.sendRedirect("../home");
        }
    }
}
