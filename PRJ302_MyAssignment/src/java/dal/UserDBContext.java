package dal;

import jakarta.servlet.http.HttpSession;
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

    // Lấy các Role của User từ bảng UserRole và Roles
    public ArrayList<Role> getRolesForUser(String username) {
        ArrayList<Role> roles = new ArrayList<>();
        String sqlRoles = "SELECT r.rid, r.rname FROM Roles r "
                + "JOIN UserRole ur ON ur.rid = r.rid "
                + "WHERE ur.username = ?";

        try (Connection conn = this.getConnection(); PreparedStatement stm = conn.prepareStatement(sqlRoles)) {

            stm.setString(1, username);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Role role = new Role();
                role.setId(rs.getInt("rid"));
                role.setName(rs.getString("rname"));

                // Lấy các Feature của Role từ bảng RoleFeature và Features
                ArrayList<Feature> features = getFeaturesForRole(role.getId());
                role.setFeatures(features);

                roles.add(role);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roles;
    }

    // Lấy các Feature của Role từ bảng RoleFeature và Features
    // Lấy các Feature của Role từ bảng RoleFeature và Features
    public ArrayList<Feature> getFeaturesForRole(int roleId) {
        ArrayList<Feature> features = new ArrayList<>();
        String sqlFeatures = "SELECT f.fid, f.url FROM Features f "
                + "JOIN RoleFeature rf ON rf.fid = f.fid "
                + "WHERE rf.rid = ?";

        try (Connection conn = this.getConnection(); PreparedStatement stm = conn.prepareStatement(sqlFeatures)) {

            stm.setInt(1, roleId);  // Set the role ID to filter features based on the role
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Feature feature = new Feature();
                feature.setId(rs.getInt("fid"));
                feature.setUrl(rs.getString("url"));
                features.add(feature); // Add the feature to the list
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Log the exception if any
        }
        return features;
    }
}
