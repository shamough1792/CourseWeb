package hkmu.wadd.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class UserDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public User getUser(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        return jdbcTemplate.queryForObject(sql, new UserRowMapper(), username);
    }

    public void updateUserPassword(String username, String password) {
        String sql = "UPDATE users SET password = ? WHERE username = ?";
        jdbcTemplate.update(sql, password, username);
    }

    public void updateUserDetails(String username, String fullName, String email, String phone) {
        String sql = "UPDATE users SET full_name = ?, email = ?, phone = ? WHERE username = ?";
        jdbcTemplate.update(sql,
                fullName != null ? fullName : "",
                email != null ? email : "",
                phone != null ? phone : "",
                username);
    }

    public List<String> getUserRoles(String username) {
        String sql = "SELECT role FROM user_roles WHERE username = ?";
        return jdbcTemplate.queryForList(sql, String.class, username);
    }

    private static class UserRowMapper implements RowMapper<User> {
        @Override
        public User mapRow(ResultSet rs, int rowNum) throws SQLException {
            User user = new User();
            user.setUsername(rs.getString("username"));
            user.setPassword(rs.getString("password"));
            user.setFullName(rs.getString("full_name"));
            user.setEmail(rs.getString("email"));
            user.setPhone(rs.getString("phone"));
            return user;
        }
    }

    @Transactional
    public void updateUsername(String oldUsername, String newUsername) {

        jdbcTemplate.execute("SET REFERENTIAL_INTEGRITY FALSE");

        try {
            jdbcTemplate.update("UPDATE users SET username = ? WHERE username = ?", newUsername, oldUsername);
            jdbcTemplate.update("UPDATE user_roles SET username = ? WHERE username = ?", newUsername, oldUsername);
            jdbcTemplate.update("UPDATE ticket SET name = ? WHERE name = ?", newUsername, oldUsername); // Keep using 'name'
            jdbcTemplate.update("UPDATE comment SET author = ? WHERE author = ?", newUsername, oldUsername);
            jdbcTemplate.update("UPDATE poll_comment SET author = ? WHERE author = ?", newUsername, oldUsername);
            jdbcTemplate.update("UPDATE vote SET username = ? WHERE username = ?", newUsername, oldUsername);
        } finally {
            jdbcTemplate.execute("SET REFERENTIAL_INTEGRITY TRUE");
        }
    }

    public static class User {
        private String username;
        private String password;
        private String fullName;
        private String email;
        private String phone;

        public String getUsername() { return username; }
        public void setUsername(String username) { this.username = username; }
        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }
        public String getFullName() { return fullName; }
        public void setFullName(String fullName) { this.fullName = fullName; }
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        public String getPhone() { return phone; }
        public void setPhone(String phone) { this.phone = phone; }
    }
}