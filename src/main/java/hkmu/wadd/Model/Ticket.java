package hkmu.wadd.Model;

import jakarta.persistence.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import java.util.ArrayList;
import java.util.List;

@Entity
public class Ticket {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "name")
    private String customerName;
    private String subject;
    private String body;

    @OneToMany(mappedBy = "ticket", fetch = FetchType.EAGER,
            cascade = CascadeType.ALL, orphanRemoval = true)
    @Fetch(FetchMode.SUBSELECT)
    private List<hkmu.wadd.Model.Attachment> attachments = new ArrayList<>();

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

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

    public List<hkmu.wadd.Model.Attachment> getAttachments() {
        return attachments;
    }

    public void setAttachments(List<hkmu.wadd.Model.Attachment> attachments) {
        this.attachments = attachments;
    }

    public void deleteAttachment(hkmu.wadd.Model.Attachment attachment) {
        attachment.setTicket(null);
        this.attachments.remove(attachment);
    }
}