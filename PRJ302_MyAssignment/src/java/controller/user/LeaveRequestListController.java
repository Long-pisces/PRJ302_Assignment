package controller.user;

import controller.authentication.BaseRequiredAuthenticationController;
import dal.LeaveRequestDBContext;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import model.LeaveRequest;
import model.User;

@WebServlet(name = "LeaveRequestListController", urlPatterns = {"/leaverequest/list"})
public class LeaveRequestListController extends BaseRequiredAuthenticationController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {

        if (!hasAccess(user, req.getServletPath())) {
            resp.setContentType("text/html;charset=UTF-8");
            resp.getWriter().println("<h2 style='color:red;'>Bạn không có quyền truy cập chức năng này.</h2>");
            return;
        }

        LeaveRequestDBContext db = new LeaveRequestDBContext();
        ArrayList<LeaveRequest> list = db.list();
        req.setAttribute("list", list);
        req.getRequestDispatcher("/view/list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        doGet(req, resp, user);
    }
}
