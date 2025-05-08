package hkmu.wadd.Controller;

import hkmu.wadd.dao.UserDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/user")
public class editUserController {

    @Autowired
    private UserDao userDao;

    @GetMapping("/edit")
    public String editUserForm(Model model, @RequestParam(required = false) String targetUsername) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String currentUsername = auth.getName();
        boolean isAdmin = auth.getAuthorities().stream()
                .anyMatch(r -> r.getAuthority().equals("ROLE_ADMIN"));

        try {
            String usernameToEdit = (isAdmin && targetUsername != null) ? targetUsername : currentUsername;
            model.addAttribute("user", userDao.getUser(usernameToEdit));
            model.addAttribute("isAdmin", isAdmin);
            return "editUser";
        } catch (Exception e) {
            return "redirect:/logout";
        }
    }

    @PostMapping("/edit")
    @Transactional
    public String editUserSubmit(
            @ModelAttribute("user") UserDao.User user,
            @RequestParam(required = false) String password,
            @RequestParam(required = false) String targetUsername,
            Model model,
            HttpServletRequest request,
            HttpServletResponse response) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String currentUsername = auth.getName();
        boolean isAdmin = auth.getAuthorities().stream()
                .anyMatch(r -> r.getAuthority().equals("ROLE_ADMIN"));

        try {
            String originalUsername = (isAdmin && targetUsername != null) ? targetUsername : currentUsername;
            String newUsername = user.getUsername();

            boolean usernameChanged = isAdmin && !newUsername.equals(originalUsername);

            if (usernameChanged) {
                try {
                    userDao.getUser(newUsername);
                    model.addAttribute("error", "Username already exists");
                    return "editUser";
                } catch (EmptyResultDataAccessException e) {
                    // Username available - proceed
                }
            }

            if (password != null && !password.isEmpty()) {
                if (password.length() < 6) {
                    model.addAttribute("error", "Password must be at least 6 characters");
                    return "editUser";
                }
                userDao.updateUserPassword(originalUsername, "{noop}" + password);
            }

            userDao.updateUserDetails(originalUsername,
                    user.getFullName(),
                    user.getEmail(),
                    user.getPhone());

            if (usernameChanged) {
                userDao.updateUsername(originalUsername, newUsername);

                if (originalUsername.equals(auth.getName())) {
                    new SecurityContextLogoutHandler().logout(request, response, auth);
                    return "redirect:/login?usernameChanged=true";
                }
            }

            return "redirect:/course/list?updateSuccess=true";

        } catch (Exception e) {
            model.addAttribute("error", "Error: " + e.getMessage());
            return "editUser";
        }
    }
}