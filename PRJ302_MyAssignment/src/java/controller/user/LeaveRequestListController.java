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
        LeaveRequestDBContext db = new LeaveRequestDBContext();
        ArrayList<LeaveRequest> list = db.list();   // Lấy toàn bộ đơn
        req.setAttribute("list", list);             // Gán cho request
        req.getRequestDispatcher("/view/list.jsp").forward(req, resp); // Chuyển tiếp đến JSP
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {
        doGet(req, resp, user);
    }
}

