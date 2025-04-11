package hkmu.wadd.Controller;

import hkmu.wadd.dao.TicketService;
import hkmu.wadd.exception.AttachmentNotFound;
import hkmu.wadd.exception.TicketNotFound;
import hkmu.wadd.Model.Attachment;
import hkmu.wadd.Model.Comment;
import hkmu.wadd.Model.Ticket;
import hkmu.wadd.view.DownloadingView;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;


import java.io.IOException;
import java.security.Principal;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/course")
public class CourseController {

    @Resource
    private TicketService tService;

    @GetMapping(value = {"", "/list"})
    public String list(ModelMap model) {
        model.addAttribute("ticketDatabase", tService.getTickets());
        return "list";
    }

    @GetMapping("/create")
    public ModelAndView create() {
        return new ModelAndView("add", "ticketForm", new Form());
    }

    public static class Form {
        private String subject;
        private String body;
        private List<MultipartFile> attachments;

        public String getSubject() {
            return subject;
        }

        public void setSubject(String subject) {
            this.subject = subject;
        }

        public String getBody() {
            return body;
        }

        public void setBody(String body) {
            this.body = body;
        }

        public List<MultipartFile> getAttachments() {
            return attachments;
        }

        public void setAttachments(List<MultipartFile> attachments) {
            this.attachments = attachments;
        }
    }

    @PostMapping("/create")
    public View create(Form form, Principal principal) throws IOException {
        long ticketId = tService.createTicket(principal.getName(),
                form.getSubject(), form.getBody(), form.getAttachments());
        return new RedirectView("/course/view/" + ticketId, true);
    }

    @GetMapping("/view/{ticketId}")
    public String view(@PathVariable("ticketId") long ticketId,
                       ModelMap model, Principal principal)
            throws TicketNotFound {
        Ticket ticket = tService.getTicket(ticketId);
        List<Comment> comments = tService.getComments(ticketId);

        model.addAttribute("ticketId", ticketId);
        model.addAttribute("ticket", ticket);
        model.addAttribute("comments", comments);
        model.addAttribute("newComment", new CommentForm());
        if (principal != null) {
            model.addAttribute("currentUser", principal.getName());
        }
        return "view";
    }

    @PostMapping("/view/{ticketId}/comment")
    public String addComment(@PathVariable("ticketId") long ticketId,
                             @Valid @ModelAttribute("newComment") CommentForm form,
                             BindingResult bindingResult,
                             Principal principal) throws TicketNotFound {
        if (principal == null) {
            return "redirect:/login";
        }

        if (bindingResult.hasErrors()) {
            return "redirect:/course/view/" + ticketId;
        }

        tService.addComment(ticketId, form.getContent(), principal.getName());
        return "redirect:/course/view/" + ticketId;
    }

    @PostMapping("/view/{ticketId}/comment/{commentId}/delete")
    public String deleteComment(@PathVariable("ticketId") long ticketId,
                                @PathVariable("commentId") long commentId,
                                Principal principal, HttpServletRequest request)
            throws TicketNotFound {
        if (principal == null) {
            return "redirect:/login";
        }

        Comment comment = tService.getComment(commentId);
        if (comment != null &&
                (request.isUserInRole("ROLE_ADMIN") ||
                        principal.getName().equals(comment.getAuthor()))) {
            tService.deleteComment(commentId);
        }

        return "redirect:/course/edit/" + ticketId;
    }

    @GetMapping("/{ticketId}/attachment/{attachment:.+}")
    public View download(@PathVariable("ticketId") long ticketId,
                         @PathVariable("attachment") UUID attachmentId)
            throws TicketNotFound, AttachmentNotFound {
        Attachment attachment = tService.getAttachment(ticketId, attachmentId);
        return new DownloadingView(attachment.getName(),
                attachment.getMimeContentType(), attachment.getContents());
    }

    @GetMapping("/delete/{ticketId}")
    public String deleteTicket(@PathVariable("ticketId") long ticketId)
            throws TicketNotFound {
        tService.delete(ticketId);
        return "redirect:/course/list";
    }

    @GetMapping("/{ticketId}/delete/{attachment:.+}")
    public String deleteAttachment(@PathVariable("ticketId") long ticketId,
                                   @PathVariable("attachment") UUID attachmentId)
            throws TicketNotFound, AttachmentNotFound {
        tService.deleteAttachment(ticketId, attachmentId);
        return "redirect:/course/edit/" + ticketId;
    }

    @GetMapping("/edit/{ticketId}")
    public ModelAndView showEdit(@PathVariable("ticketId") long ticketId,
                                 Principal principal, HttpServletRequest request)
            throws TicketNotFound {
        Ticket ticket = tService.getTicket(ticketId);
        if (ticket == null
                || (!request.isUserInRole("ROLE_ADMIN")
                && !principal.getName().equals(ticket.getCustomerName()))) {
            return new ModelAndView(new RedirectView("/course/list", true));
        }

        ModelAndView modelAndView = new ModelAndView("edit");
        modelAndView.addObject("ticket", ticket);
        modelAndView.addObject("comments", tService.getComments(ticketId)); // Add this line

        Form ticketForm = new Form();
        ticketForm.setSubject(ticket.getSubject());
        ticketForm.setBody(ticket.getBody());
        modelAndView.addObject("ticketForm", ticketForm);

        return modelAndView;
    }

    @PostMapping("/edit/{ticketId}")
    public String edit(@PathVariable("ticketId") long ticketId, Form form,
                       Principal principal, HttpServletRequest request)
            throws IOException, TicketNotFound {
        Ticket ticket = tService.getTicket(ticketId);
        if (ticket == null
                || (!request.isUserInRole("ROLE_ADMIN")
                && !principal.getName().equals(ticket.getCustomerName()))) {
            return "redirect:/course/list";
        }

        tService.updateTicket(ticketId, form.getSubject(),
                form.getBody(), form.getAttachments());
        return "redirect:/course/view/" + ticketId;
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

    @ExceptionHandler({TicketNotFound.class, AttachmentNotFound.class})
    public ModelAndView error(Exception e) {
        return new ModelAndView("error", "message", e.getMessage());
    }
}