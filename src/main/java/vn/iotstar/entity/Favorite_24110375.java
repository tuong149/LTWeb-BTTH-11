package vn.iotstar.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "Favorites")
public class Favorite_24110375 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "FavoriteId")
    private Integer favoriteId;

    @Column(name = "LikedDate")
    @Temporal(TemporalType.DATE)
    private Date likedDate;

    @ManyToOne
    @JoinColumn(name = "Username", nullable = false)
    private User_24110375 user;

    @ManyToOne
    @JoinColumn(name = "VideoId", nullable = false)
    private Video_24110375 video;

    public Favorite_24110375() {}

    public Integer getFavoriteId() { return favoriteId; }
    public void setFavoriteId(Integer favoriteId) { this.favoriteId = favoriteId; }

    public Date getLikedDate() { return likedDate; }
    public void setLikedDate(Date likedDate) { this.likedDate = likedDate; }

    public User_24110375 getUser() { return user; }
    public void setUser(User_24110375 user) { this.user = user; }

    public Video_24110375 getVideo() { return video; }
    public void setVideo(Video_24110375 video) { this.video = video; }
}

