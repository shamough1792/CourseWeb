// CommentHistoryController.java
package hkmu.wadd.Controller;

import hkmu.wadd.Model.Comment;
import hkmu.wadd.Model.PollComment;
import hkmu.wadd.service.UserCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.stream.Collectors;

@Controller
public class CommentHistoryController {
    @Autowired
    private UserCommentService userCommentService;

    @GetMapping("/user/comments")
    public ModelAndView showCommentHistory() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String currentUserName = authentication.getName();

        List<Comment> courseComments = userCommentService.getCourseCommentsByAuthor(currentUserName);
        List<PollComment> pollComments = userCommentService.getPollCommentsByAuthor(currentUserName);

        List<CommentWithSubject> commentsWithSubjects = courseComments.stream()
                .map(comment -> new CommentWithSubject(
                        comment,
                        comment.getTicket() != null ? comment.getTicket().getSubject() : "No subject"
                ))
                .collect(Collectors.toList());

        ModelAndView mav = new ModelAndView("commentHistory");
        mav.addObject("courseComments", commentsWithSubjects);
        mav.addObject("pollComments", pollComments);
        mav.addObject("username", currentUserName);

        return mav;
    }

    public static class CommentWithSubject {
        private Comment comment;
        private String subject;

        public CommentWithSubject(Comment comment, String subject) {
            this.comment = comment;
            this.subject = subject;
        }

        public Comment getComment() { return comment; }
        public String getSubject() { return subject; }
    }
}