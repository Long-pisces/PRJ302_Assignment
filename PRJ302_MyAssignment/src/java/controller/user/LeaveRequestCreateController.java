package controller.user;

import controller.authentication.BaseRequiredAuthenticationController;
import dal.LeaveRequestDBContext;
import dal.UserDBContext;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Employee;
import model.LeaveRequest;
import model.User;

@WebServlet(name = "LeaveRequestCreateController", urlPatterns = {"/leaverequest/create"})
public class LeaveRequestCreateController extends BaseRequiredAuthenticationController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        req.getRequestDispatcher("/view/create.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        String reason = req.getParameter("reason");
        Date from = Date.valueOf(req.getParameter("from"));
        Date to = Date.valueOf(req.getParameter("to"));

        // Tìm người có role là "Manager"
        String managerUsername = getFirstManagerUsername();

        LeaveRequest lr = new LeaveRequest();
        lr.setReason(reason);
        lr.setFrom(from);
        lr.setTo(to);
        lr.setStatus(0); // "In Progress"
        lr.setCreatedBy(user);
        lr.setProcessedBy(managerUsername);

        Employee emp = new Employee();
        emp.setId(user.getEid()); // owner_eid
        lr.setOwner(emp);

        LeaveRequestDBContext db = new LeaveRequestDBContext();
        db.insert(lr);

        resp.sendRedirect("../home");
    }

    private String getFirstManagerUsername() {
        String sql = "SELECT TOP 1 u.username FROM Users u " +
                     "JOIN UserRole ur ON u.username = ur.username " +
                     "JOIN Roles r ON ur.rid = r.rid " +
                     "WHERE r.rname = 'Manager'";

        try (Connection conn = new UserDBContext().getConnection();
             PreparedStatement stm = conn.prepareStatement(sql);
             ResultSet rs = stm.executeQuery()) {
            if (rs.next()) {
                return rs.getString("username");
            }
        } catch (SQLException e) {
            System.out.println("❌ Lỗi lấy username Manager: " + e.getMessage());
        }
        return null;
    }
}
