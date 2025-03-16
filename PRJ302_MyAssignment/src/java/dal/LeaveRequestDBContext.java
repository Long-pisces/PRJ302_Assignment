package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Employee;
import model.LeaveRequest;
import model.User;

public class LeaveRequestDBContext extends DBContext<LeaveRequest> {

    @Override
    public void insert(LeaveRequest lr) {
        String sql = "INSERT INTO LeaveRequests " +
                     "([reason], [from], [to], [status], [createdby], [createddate], [owner_eid], [processedby]) " +
                     "VALUES (?, ?, ?, ?, ?, GETDATE(), ?, ?)";

        try {
            System.out.println("==> [DAL] Bắt đầu insert LeaveRequest");

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, lr.getReason());
            stm.setDate(2, lr.getFrom());
            stm.setDate(3, lr.getTo());
            stm.setInt(4, lr.getStatus()); // 0 = In Progress
            stm.setString(5, lr.getCreatedBy().getUsername());
            stm.setInt(6, lr.getOwner().getId());
            stm.setString(7, lr.getProcessedBy());

            int rows = stm.executeUpdate();
            System.out.println("✅ [DAL] Rows affected: " + rows);

        } catch (SQLException e) {
            System.out.println("❌ [DAL] Lỗi khi insert LeaveRequest: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeConnection();
        }
    }

    @Override
    public ArrayList<LeaveRequest> list() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public LeaveRequest get(int id) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void update(LeaveRequest model) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void delete(LeaveRequest model) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("==> [DAL] Đã đóng kết nối DB");
            }
        } catch (SQLException e) {
            System.out.println("❌ [DAL] Không thể đóng kết nối: " + e.getMessage());
        }
    }
}
