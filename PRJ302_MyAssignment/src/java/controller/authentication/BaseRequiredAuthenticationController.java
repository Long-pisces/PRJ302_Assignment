/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.authentication;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.User;

/**
 *
 * @author sonnt-local
 */
public abstract class BaseRequiredAuthenticationController extends HttpServlet {
    //Xác định ai đang đăng nhập
    private User getLoggedUser(HttpServletRequest req) {
        return (User) req.getSession().getAttribute("user");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User u = getLoggedUser(req);
        if (u != null) {
            //do business
            doPost(req, resp, u);
        } else {
            resp.getWriter().println("access denied!");
        }
    }

    protected abstract void doPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException;

    protected abstract void doGet(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User u = getLoggedUser(req);
        if (u != null) {
            //do business
            doGet(req, resp, u);
        } else {
            resp.getWriter().println("access denied!");
        }
    }

    protected boolean hasAccess(User user, String path) {
        return user.getRoles().stream()
                .flatMap(role -> role.getFeatures().stream())
                .anyMatch(feature -> feature.getUrl().equals(path));
    }

}
