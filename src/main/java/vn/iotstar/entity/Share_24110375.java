package vn.iotstar.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "Shares")
public class Share_24110375 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ShareId")
    private Integer shareId;

    @Column(name = "Emails", length = 50)
    private String emails;

    @Column(name = "SharedDate")
    @Temporal(TemporalType.DATE)
    private Date sharedDate;

    @ManyToOne
    @JoinColumn(name = "Username", nullable = false)
    private User_24110375 user;

    @ManyToOne
    @JoinColumn(name = "VideoId", nullable = false)
    private Video_24110375 video;

    public Share_24110375() {}

    public Integer getShareId() { return shareId; }
    public void setShareId(Integer shareId) { this.shareId = shareId; }

    public String getEmails() { return emails; }
    public void setEmails(String emails) { this.emails = emails; }

    public Date getSharedDate() { return sharedDate; }
    public void setSharedDate(Date sharedDate) { this.sharedDate = sharedDate; }

    public User_24110375 getUser() { return user; }
    public void setUser(User_24110375 user) { this.user = user; }

    public Video_24110375 getVideo() { return video; }
    public void setVideo(Video_24110375 video) { this.video = video; }
}

