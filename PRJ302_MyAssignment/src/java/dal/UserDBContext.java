package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Feature;
import model.Role;
import model.User;

public class UserDBContext extends DBContext<User> {

    public User get(String username, String password) {
        try {
            String sql = "SELECT u.username, u.displayname, u.eid, "
                    + "       r.rid, r.rname, "
                    + "       f.fid, f.url "
                    + "FROM Users u "
                    + "LEFT JOIN UserRole ur ON ur.username = u.username "
                    + "LEFT JOIN Roles r ON r.rid = ur.rid "
                    + "LEFT JOIN RoleFeature rf ON r.rid = rf.rid "
                    + "LEFT JOIN Features f ON f.fid = rf.fid "
                    + "WHERE u.username = ? AND u.password = ?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, password);
            ResultSet rs = stm.executeQuery();

            User user = null;
            Role current_role = new Role();
            current_role.setId(-1);

            while (rs.next()) {
                if (user == null) {
                    user = new User();
                    user.setUsername(username);
                    user.setDisplayname(rs.getNString("displayname"));
                    user.setEid(rs.getInt("eid")); // ✅ Gán eid từ DB
                }

                int rid = rs.getInt("rid");
                if (rid > 0 && rid != current_role.getId()) {
                    current_role = new Role();
                    current_role.setId(rid);
                    current_role.setName(rs.getString("rname"));
                    current_role.getUsers().add(user);
                    user.getRoles().add(current_role);
                }

                int fid = rs.getInt("fid");
                if (fid > 0) {
                    Feature f = new Feature();
                    f.setId(fid);
                    f.setUrl(rs.getString("url"));
                    current_role.getFeatures().add(f);
                    f.getRoles().add(current_role);
                }
            }

            return user;

        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return null;
    }

    @Override
    public ArrayList<User> list() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public User get(int id) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void insert(User model) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void update(User model) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void delete(User model) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}
