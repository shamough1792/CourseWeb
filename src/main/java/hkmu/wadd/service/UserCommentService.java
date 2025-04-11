package hkmu.wadd.service;

import hkmu.wadd.Model.Comment;
import hkmu.wadd.Model.PollComment;
import hkmu.wadd.dao.CommentRepository;
import hkmu.wadd.dao.PollCommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserCommentService {
    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private PollCommentRepository pollCommentRepository;

    public List<Comment> getCourseCommentsByAuthor(String author) {
        return commentRepository.findByAuthor(author);
    }

    public List<PollComment> getPollCommentsByAuthor(String author) {
        return pollCommentRepository.findByAuthorWithPoll(author);
    }
}