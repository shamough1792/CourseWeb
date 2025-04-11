package hkmu.wadd.dao;

import hkmu.wadd.Model.*;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class PollService {
    @Resource
    private PollRepository pollRepo;

    @Resource
    private VoteRepository voteRepo;

    @Resource
    private PollCommentRepository pollCommentRepo;

    @Transactional
    public List<Poll> getPolls() {
        return pollRepo.findAll();
    }

    @Transactional
    public Poll getPoll(Long id) {
        return pollRepo.findById(id).orElse(null);
    }

    @Transactional
    public void createPoll(Poll poll) {
        pollRepo.save(poll);
    }

    @Transactional
    public void deletePoll(Long id) {
        pollRepo.deleteById(id);
    }

    @Transactional
    public void vote(Long pollId, String username, int selectedOption) {
        Vote existingVote = voteRepo.findByPollIdAndUsername(pollId, username);

        if (existingVote != null) {
            existingVote.setSelectedOption(selectedOption);
            voteRepo.save(existingVote);
        } else {
            Poll poll = pollRepo.findById(pollId).orElseThrow();
            Vote vote = new Vote();
            vote.setPoll(poll);
            vote.setUsername(username);
            vote.setSelectedOption(selectedOption);
            voteRepo.save(vote);
        }
    }

    @Transactional
    public Integer getUserVote(Long pollId, String username) {
        Vote vote = voteRepo.findByPollIdAndUsername(pollId, username);
        return vote != null ? vote.getSelectedOption() : null;
    }

    @Transactional
    public List<Integer> getVoteCounts(Long pollId) {
        List<Integer> counts = new ArrayList<>(4);
        for (int i = 0; i < 4; i++) {
            counts.add(0);
        }

        List<Object[]> results = voteRepo.countVotesByOption(pollId);
        for (Object[] result : results) {
            int option = (int) result[0];
            long count = (long) result[1];
            counts.set(option, (int) count);
        }

        return counts;
    }

    @Transactional
    public void addComment(Long pollId, String content, String author) {
        Poll poll = pollRepo.findById(pollId).orElseThrow();
        PollComment comment = new PollComment();
        comment.setPoll(poll);
        comment.setContent(content);
        comment.setAuthor(author);
        comment.setCreatedAt(LocalDateTime.now());
        pollCommentRepo.save(comment);
    }

    @Transactional
    public List<PollComment> getComments(Long pollId) {
        return pollCommentRepo.findByPollId(pollId);
    }

    @Transactional
    public List<Vote> getVotingHistory(String username) {
        return voteRepo.findByUsername(username);
    }

    @Transactional
    public void updatePoll(Poll poll) {
        pollRepo.save(poll);
    }

    @Transactional
    public void deleteComment(Long commentId) {
        PollComment comment = pollCommentRepo.findById(commentId).orElse(null);
        if (comment != null) {
            Poll poll = comment.getPoll();
            if (poll != null) {
                poll.getComments().remove(comment);
            }
            pollCommentRepo.delete(comment);
        }
    }

}