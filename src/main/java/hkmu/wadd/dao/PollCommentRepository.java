package hkmu.wadd.dao;

import hkmu.wadd.Model.PollComment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PollCommentRepository extends JpaRepository<PollComment, Long> {
    List<PollComment> findByPollId(Long pollId);
    List<PollComment> findByAuthor(String author);

    @Query("SELECT pc FROM PollComment pc JOIN FETCH pc.poll WHERE pc.author = :author")
    List<PollComment> findByAuthorWithPoll(@Param("author") String author);
}