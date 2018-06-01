package dto;

import java.sql.Timestamp;

public class ProjectUserDto {
    private int id;
    private int project_id;
    private int user_id;
    private String user_name;
    private String login_name;
    private Timestamp create_time;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProject_id() {
        return project_id;
    }

    public void setProject_id(int project_id) {
        this.project_id = project_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getLogin_name() {
        return login_name;
    }

    public void setLogin_name(String login_name) {
        this.login_name = login_name;
    }

    public Timestamp getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Timestamp create_time) {
        this.create_time = create_time;
    }

    @Override
    public String toString() {
        return "ProjectUserDto{" +
                "id=" + id +
                ", project_id=" + project_id +
                ", user_id=" + user_id +
                ", user_name='" + user_name + '\'' +
                ", login_name='" + login_name + '\'' +
                ", create_time=" + create_time +
                '}';
    }
}