package vn.iotstar.entity;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "Videos")
public class Video_24110375 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "VideoId", length = 50, nullable = false)
    private String videoId;

    @Column(name = "Title", length = 200, nullable = false)
    private String title;

    @Column(name = "Poster", length = 50)
    private String poster;

    @Column(name = "Views")
    private Integer views = 0;

    @Column(name = "Description", length = 500)
    private String description;

    @Column(name = "Active")
    private Boolean active = true;

    @ManyToOne
    @JoinColumn(name = "CategoryId", nullable = false)
    private Category_24110375 category;

    public Video_24110375() {}

    public String getVideoId() { return videoId; }
    public void setVideoId(String videoId) { this.videoId = videoId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getPoster() { return poster; }
    public void setPoster(String poster) { this.poster = poster; }

    public Integer getViews() { return views; }
    public void setViews(Integer views) { this.views = views; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Boolean getActive() { return active; }
    public void setActive(Boolean active) { this.active = active; }

    public Category_24110375 getCategory() { return category; }
    public void setCategory(Category_24110375 category) { this.category = category; }
}

