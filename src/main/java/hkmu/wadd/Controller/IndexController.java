package hkmu.wadd.Controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IndexController {
    @GetMapping("/")
    public String index() {
        return "redirect:/course/list";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }
}
