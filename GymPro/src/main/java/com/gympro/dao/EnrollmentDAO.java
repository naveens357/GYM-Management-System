package com.gympro.dao;

import com.gympro.model.ClassEnrollment;
import com.gympro.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for class_enrollments table.
 * Enrollment/cancellation uses shared Connection for transaction support.
 */
public class EnrollmentDAO {

    /** Insert enrollment using an existing connection (inside transaction). */
    public void insert(Connection conn, int userId, int classId) throws SQLException {
        PreparedStatement ps = conn.prepareStatement(
            "INSERT INTO class_enrollments (user_id,class_id) VALUES (?,?)");
        ps.setInt(1, userId);
        ps.setInt(2, classId);
        ps.executeUpdate();
    }

    /** Delete enrollment using existing connection (inside transaction). */
    public int delete(Connection conn, int userId, int classId) throws SQLException {
        PreparedStatement ps = conn.prepareStatement(
            "DELETE FROM class_enrollments WHERE user_id=? AND class_id=?");
        ps.setInt(1, userId);
        ps.setInt(2, classId);
        return ps.executeUpdate();
    }

    /** Check remaining capacity — uses FOR UPDATE to lock the row. */
    public boolean hasCapacity(Connection conn, int classId) throws SQLException {
        PreparedStatement ps = conn.prepareStatement(
            "SELECT capacity, enrolled_count FROM classes WHERE class_id=? FOR UPDATE");
        ps.setInt(1, classId);
        ResultSet rs = ps.executeQuery();
        return rs.next() && rs.getInt("enrolled_count") < rs.getInt("capacity");
    }

    /** Check if user is already enrolled (active). */
    public boolean isEnrolled(int userId, int classId) throws SQLException {
        String sql = "SELECT 1 FROM class_enrollments WHERE user_id=? AND class_id=? AND status='enrolled'";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, classId);
            return ps.executeQuery().next();
        } finally { DBConnection.close(conn); }
    }

    /** Enrollments for a member, joined with class + trainer info. */
    public List<ClassEnrollment> findByUser(int userId) throws SQLException {
        List<ClassEnrollment> list = new ArrayList<>();
        String sql = "SELECT ce.*,c.class_name,c.schedule_datetime,c.duration_minutes,t.full_name AS trainer_name " +
                     "FROM class_enrollments ce " +
                     "JOIN classes c  ON ce.class_id=c.class_id " +
                     "JOIN trainers t ON c.trainer_id=t.trainer_id " +
                     "WHERE ce.user_id=? ORDER BY c.schedule_datetime ASC";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ClassEnrollment e = new ClassEnrollment();
                e.setEnrollmentId(rs.getInt("enrollment_id"));
                e.setUserId(rs.getInt("user_id"));
                e.setClassId(rs.getInt("class_id"));
                e.setEnrolledDate(rs.getTimestamp("enrolled_date"));
                e.setStatus(rs.getString("status"));
                e.setClassName(rs.getString("class_name"));
                e.setScheduleDatetime(rs.getTimestamp("schedule_datetime"));
                e.setDurationMinutes(rs.getInt("duration_minutes"));
                e.setTrainerName(rs.getString("trainer_name"));
                list.add(e);
            }
        } finally { DBConnection.close(conn); }
        return list;
    }
}
