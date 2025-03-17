package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Employee;
import model.LeaveRequest;
import model.User;
import java.sql.*;

public class LeaveRequestDBContext extends DBContext<LeaveRequest> {

    @Override
    public void insert(LeaveRequest lr) {
        String sql = "INSERT INTO LeaveRequests "
                + "([reason], [from], [to], [status], [createdby], [createddate], [owner_eid], [processedby]) "
                + "VALUES (?, ?, ?, ?, ?, GETDATE(), ?, ?)";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, lr.getReason());
            stm.setDate(2, lr.getFrom());
            stm.setDate(3, lr.getTo());
            stm.setInt(4, lr.getStatus()); // 0 = In Progress
            stm.setString(5, lr.getCreatedBy().getUsername());
            stm.setInt(6, lr.getOwner().getId());
            stm.setString(7, lr.getProcessedBy());

            int rows = stm.executeUpdate();
            System.out.println("Rows affected: " + rows);

        } catch (SQLException e) {
            System.out.println("Lỗi khi insert LeaveRequest: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeConnection();
        }
    }

    @Override
    public ArrayList<LeaveRequest> list() {
        ArrayList<LeaveRequest> list = new ArrayList<>();
        String sql = "SELECT lr.lrid, lr.reason, lr.[from], lr.[to], "
                + "lr.status, "
                + "u.displayname AS creator_name, "
                + "pu.displayname AS processor_name "
                + "FROM LeaveRequests lr "
                + "LEFT JOIN Users u ON lr.createdby = u.username "
                + "LEFT JOIN Users pu ON lr.processedby = pu.username";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                LeaveRequest lr = new LeaveRequest();
                lr.setId(rs.getInt("lrid"));
                lr.setReason(rs.getString("reason"));
                lr.setFrom(rs.getDate("from"));
                lr.setTo(rs.getDate("to"));
                lr.setStatus(rs.getInt("status"));

                // Gán người tạo
                User creator = new User();
                creator.setDisplayname(rs.getString("creator_name")); // Có thể null nếu không join được
                lr.setCreatedBy(creator);

                // Gán người xử lý
                String processorDisplay = rs.getString("processor_name");
                lr.setProcessedBy(processorDisplay != null ? processorDisplay : "N/A");

                list.add(lr);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return list;
    }

    @Override
    public LeaveRequest get(int id) {
        String sql = "SELECT lrid, reason, [from], [to], createdby FROM LeaveRequests WHERE lrid = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                LeaveRequest lr = new LeaveRequest();
                lr.setId(rs.getInt("lrid"));
                lr.setReason(rs.getString("reason"));
                lr.setFrom(rs.getDate("from"));
                lr.setTo(rs.getDate("to"));

                User creator = new User();
                creator.setUsername(rs.getString("createdby"));
                lr.setCreatedBy(creator);

                return lr;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return null;
    }

    @Override
    public void update(LeaveRequest lr) {
        String sql = "UPDATE LeaveRequests SET reason = ?, [from] = ?, [to] = ?, createddate = GETDATE() WHERE lrid = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, lr.getReason());
            stm.setDate(2, lr.getFrom());
            stm.setDate(3, lr.getTo());
            stm.setInt(4, lr.getId());
            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
    }

    @Override
    public void delete(LeaveRequest lr) {
        String sql = "DELETE FROM LeaveRequests WHERE lrid = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, lr.getId());
            int rows = stm.executeUpdate();
            System.out.println("Rows affected: " + rows);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
    }

    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("Đã đóng kết nối DB");
            }
        } catch (SQLException e) {
            System.out.println("Không thể đóng kết nối: " + e.getMessage());
        }
    }
}
