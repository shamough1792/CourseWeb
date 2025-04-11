package hkmu.wadd.dao;

import hkmu.wadd.Model.Comment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CommentRepository extends JpaRepository<Comment, Long> {
    List<Comment> findByTicketId(Long ticketId);
    List<Comment> findByAuthor(String author);
}