package hkmu.wadd.exception;

public class TicketNotFound extends Exception {
    public TicketNotFound(long id) {
        super("Course ID " + id + " does not exist.");
    }
}