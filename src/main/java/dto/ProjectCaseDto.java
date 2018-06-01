package dto;

import java.sql.Timestamp;

public class ProjectCaseDto {
    private int id;
    private int project_id;
    private int case_id;
    private String name;
    private String description;
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

    public int getCase_id() {
        return case_id;
    }

    public void setCase_id(int case_id) {
        this.case_id = case_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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
                ", case_id=" + case_id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", create_time=" + create_time +
                '}';
    }
}