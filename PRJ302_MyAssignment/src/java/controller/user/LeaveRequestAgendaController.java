package controller.user;

import controller.authentication.BaseRequiredAuthenticationController;
import dal.LeaveRequestDBContext;
import dal.UserDBContext;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Employee;
import model.LeaveRequest;
import model.User;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.*;

@WebServlet(name = "LeaveRequestAgendaController", urlPatterns = {"/leaverequest/agenda"})
public class LeaveRequestAgendaController extends BaseRequiredAuthenticationController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {

        if (!hasAccess(user, req.getServletPath())) {
            resp.setContentType("text/html;charset=UTF-8");
            resp.getWriter().println("<h2 style='color:red;'>Bạn không có quyền truy cập trang này.</h2>");
            return;
        }

        LocalDate startDate = (LocalDate) req.getAttribute("startDate");
        LocalDate endDate = (LocalDate) req.getAttribute("endDate");

        if (startDate != null && endDate != null) {
            LeaveRequestDBContext lrDB = new LeaveRequestDBContext();
            UserDBContext userDB = new UserDBContext();

            ArrayList<Employee> employees = userDB.getAllEmployees();
            ArrayList<LeaveRequest> approvedLeaves = lrDB.getApprovedLeavesBetween(Date.valueOf(startDate), Date.valueOf(endDate));

            Map<Integer, Set<LocalDate>> leaveMap = new HashMap<>();
            for (LeaveRequest lr : approvedLeaves) {
                int eid = lr.getOwner().getId();
                leaveMap.putIfAbsent(eid, new HashSet<>());
                LocalDate from = lr.getFrom().toLocalDate();
                LocalDate to = lr.getTo().toLocalDate();
                for (LocalDate d = from; !d.isAfter(to); d = d.plusDays(1)) {
                    leaveMap.get(eid).add(d);
                }
            }
            //tạo danh sách các ngày trong khoảng đã chọn 
            List<LocalDate> dates = new ArrayList<>();
            for (LocalDate d = startDate; !d.isAfter(endDate); d = d.plusDays(1)) {
                dates.add(d);
            }

            req.setAttribute("employees", employees);
            req.setAttribute("leaveMap", leaveMap);
            req.setAttribute("startDate", startDate);
            req.setAttribute("endDate", endDate);
            req.setAttribute("dates", dates);
        }

        req.getRequestDispatcher("/view/agenda.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user)
            throws ServletException, IOException {

        String startRaw = req.getParameter("start");
        String endRaw = req.getParameter("end");

        if (startRaw != null && endRaw != null) {
            LocalDate startDate = LocalDate.parse(startRaw);
            LocalDate endDate = LocalDate.parse(endRaw);
            req.setAttribute("startDate", startDate);
            req.setAttribute("endDate", endDate);
        }

        doGet(req, resp, user);
    }
}