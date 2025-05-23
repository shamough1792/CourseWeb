package hkmu.wadd.dao;

import hkmu.wadd.Model.TicketUser;
import jakarta.annotation.Resource;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserManagementService {
    @Resource
    private TicketUserRepository tuRepo;

    @Transactional
    public List<TicketUser> getTicketUsers() {
        return tuRepo.findAll();
    }

    @Transactional
    public void delete(String username) {
        TicketUser ticketUser = tuRepo.findById(username).orElse(null);
        if (ticketUser == null) {
            throw new UsernameNotFoundException("User '" + username + "' not found.");
        }
        tuRepo.delete(ticketUser);
    }

    @Transactional
    public void createTicketUser(String username, String password, String fullName, String email, String phone, String[] roles) {
        TicketUser user = new TicketUser(username, password, fullName, email, phone, roles);
        tuRepo.save(user);
    }
}