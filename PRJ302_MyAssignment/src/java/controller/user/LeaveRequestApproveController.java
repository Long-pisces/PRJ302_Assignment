package controller.user;

import controller.authentication.BaseRequiredAuthenticationController;
import dal.LeaveRequestDBContext;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.LeaveRequest;
import model.User;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "LeaveRequestApproveController", urlPatterns = {"/leaverequest/approve"})
public class LeaveRequestApproveController extends BaseRequiredAuthenticationController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {

        if (!hasAccess(user, req.getServletPath())) {
            resp.setContentType("text/html;charset=UTF-8");
            resp.getWriter().println("<h2 style='color:red;'>Bạn không có quyền truy cập trang này.</h2>");
            return;
        }

        LeaveRequestDBContext dbContext = new LeaveRequestDBContext();
        ArrayList<LeaveRequest> leaveRequests = dbContext.getLeaveRequestsInProgress();
        req.setAttribute("leaveRequests", leaveRequests);
        req.getRequestDispatcher("/view/approve.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {

        if (!hasAccess(user, req.getServletPath())) {
            resp.setContentType("text/html;charset=UTF-8");
            resp.getWriter().println("<h2 style='color:red;'>Bạn không có quyền truy cập trang này.</h2>");
            return;
        }

        int lrid = Integer.parseInt(req.getParameter("lrid"));
        String action = req.getParameter("action");

        LeaveRequestDBContext dbContext = new LeaveRequestDBContext();

        if ("approve".equals(action)) {
            dbContext.updateLeaveRequestStatus(lrid, 1, user.getUsername());
        } else if ("reject".equals(action)) {
            dbContext.updateLeaveRequestStatus(lrid, 2, user.getUsername());
        }

        resp.sendRedirect(req.getContextPath() + "/leaverequest/approve");
    }
}
