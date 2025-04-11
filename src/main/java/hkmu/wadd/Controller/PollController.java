package hkmu.wadd.Controller;

import hkmu.wadd.Model.Poll;
import hkmu.wadd.dao.PollService;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

import java.security.Principal;
import java.util.List;



@Controller
@RequestMapping("/poll")
public class PollController {
    @Resource
    private PollService pollService;


    @Autowired
    private HttpServletRequest request;

    @GetMapping("")
    public String list(ModelMap model) {
        model.addAttribute("polls", pollService.getPolls());
        return "pollList";
    }

    @GetMapping("/view/{pollId}")
    public String view(@PathVariable("pollId") Long pollId, ModelMap model, Principal principal) {
        Poll poll = pollService.getPoll(pollId);
        if (poll == null) {
            return "redirect:/poll";
        }

        model.addAttribute("poll", poll);
        model.addAttribute("voteCounts", pollService.getVoteCounts(pollId));

        if (principal != null) {
            Integer userVote = pollService.getUserVote(pollId, principal.getName());
            model.addAttribute("userVote", userVote);
            model.addAttribute("currentUser", principal.getName());
        }

        model.addAttribute("comments", pollService.getComments(pollId));
        model.addAttribute("newComment", new CommentForm());

        return "pollView";
    }

    @PostMapping("/vote/{pollId}")
    public String vote(@PathVariable("pollId") Long pollId,
                       @RequestParam(value = "option", required = false) Integer option,
                       Principal principal,
                       ModelMap model) {
        if (principal == null) {
            return "redirect:/login";
        }

        if (option == null) {
            Poll poll = pollService.getPoll(pollId);
            model.addAttribute("poll", poll);
            model.addAttribute("voteCounts", pollService.getVoteCounts(pollId));
            model.addAttribute("userVote", pollService.getUserVote(pollId, principal.getName()));
            model.addAttribute("currentUser", principal.getName());
            model.addAttribute("comments", pollService.getComments(pollId));
            model.addAttribute("newComment", new CommentForm());
            model.addAttribute("voteError", "Please select an option before voting");
            return "pollView";
        }

        pollService.vote(pollId, principal.getName(), option);
        return "redirect:/poll/view/" + pollId;
    }

    @PostMapping("/view/{pollId}/comment")
    public String addComment(@PathVariable("pollId") Long pollId,
                             @Valid @ModelAttribute("newComment") CommentForm form,
                             BindingResult bindingResult,
                             Principal principal,
                             ModelMap model) {
        if (principal == null) {
            return "redirect:/login";
        }

        if (bindingResult.hasErrors()) {
            Poll poll = pollService.getPoll(pollId);
            model.addAttribute("poll", poll);
            model.addAttribute("voteCounts", pollService.getVoteCounts(pollId));
            model.addAttribute("userVote", pollService.getUserVote(pollId, principal.getName()));
            model.addAttribute("currentUser", principal.getName());
            model.addAttribute("comments", pollService.getComments(pollId));
            return "pollView";
        }

        pollService.addComment(pollId, form.getContent(), principal.getName());
        return "redirect:/poll/view/" + pollId;
    }

    @GetMapping("/create")
    public ModelAndView create() {
        return new ModelAndView("pollCreate", "pollForm", new PollForm());
    }

    @PostMapping("/create")
    public View create(PollForm form) {
        Poll poll = new Poll();
        poll.setQuestion(form.getQuestion());
        poll.setOptions(List.of(
                form.getOption1(),
                form.getOption2(),
                form.getOption3(),
                form.getOption4()
        ));

        pollService.createPoll(poll);
        return new RedirectView("/poll", true);
    }

    @GetMapping("/delete/{pollId}")
    public View delete(@PathVariable("pollId") Long pollId) {
        pollService.deletePoll(pollId);
        return new RedirectView("/poll", true);
    }

    public static class PollForm {
        private String question;
        private String option1;
        private String option2;
        private String option3;
        private String option4;

        public String getQuestion() {
            return question;
        }

        public void setQuestion(String question) {
            this.question = question;
        }

        public String getOption1() {
            return option1;
        }

        public void setOption1(String option1) {
            this.option1 = option1;
        }

        public String getOption2() {
            return option2;
        }

        public void setOption2(String option2) {
            this.option2 = option2;
        }

        public String getOption3() {
            return option3;
        }

        public void setOption3(String option3) {
            this.option3 = option3;
        }

        public String getOption4() {
            return option4;
        }

        public void setOption4(String option4) {
            this.option4 = option4;
        }
    }

    public static class CommentForm {
        @NotBlank(message = "Comment cannot be empty")
        private String content;

        public String getContent() {
            return content;
        }

        public void setContent(String content) {
            this.content = content;
        }
    }

    @GetMapping("/history")
    public String votingHistory(Principal principal, ModelMap model) {
        if (principal == null) {
            return "redirect:/login";
        }

        model.addAttribute("votes", pollService.getVotingHistory(principal.getName()));
        return "votingHistory";
    }

    @GetMapping("/edit/{pollId}")
    public String editForm(@PathVariable("pollId") Long pollId, ModelMap model) {
        Poll poll = pollService.getPoll(pollId);
        if (poll == null) {
            return "redirect:/poll";
        }

        PollForm form = new PollForm();
        form.setQuestion(poll.getQuestion());
        if (poll.getOptions().size() >= 1) form.setOption1(poll.getOptions().get(0));
        if (poll.getOptions().size() >= 2) form.setOption2(poll.getOptions().get(1));
        if (poll.getOptions().size() >= 3) form.setOption3(poll.getOptions().get(2));
        if (poll.getOptions().size() >= 4) form.setOption4(poll.getOptions().get(3));

        model.addAttribute("pollForm", form);
        model.addAttribute("pollId", pollId);
        return "pollEdit";
    }

    @PostMapping("/edit/{pollId}")
    public View edit(@PathVariable("pollId") Long pollId, PollForm form) {
        Poll poll = pollService.getPoll(pollId);
        if (poll != null) {
            poll.setQuestion(form.getQuestion());
            poll.setOptions(List.of(
                    form.getOption1(),
                    form.getOption2(),
                    form.getOption3(),
                    form.getOption4()
            ));
            pollService.updatePoll(poll);
        }
        return new RedirectView("/poll", true);
    }

    @GetMapping("/comment/delete/{commentId}")
    public View deleteComment(@PathVariable("commentId") Long commentId, Principal principal) {
        if (principal != null) {
            pollService.deleteComment(commentId);
        }
        String referer = request.getHeader("Referer");
        return new RedirectView(referer != null ? referer : "/poll", true);
    }

}