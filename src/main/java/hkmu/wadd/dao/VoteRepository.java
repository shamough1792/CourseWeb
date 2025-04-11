package hkmu.wadd.dao;

import hkmu.wadd.Model.Vote;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface VoteRepository extends JpaRepository<Vote, Long> {
    Vote findByPollIdAndUsername(Long pollId, String username);

    @Query("SELECT v.selectedOption, COUNT(v) FROM Vote v WHERE v.poll.id = :pollId GROUP BY v.selectedOption")
    List<Object[]> countVotesByOption(@Param("pollId") Long pollId);

    List<Vote> findByUsername(String username);

}