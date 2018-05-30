package dto;

import entity.Case;
import entity.User;

import java.lang.reflect.Field;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class ProjectStatistic {
    private int id;
    private int test_progress;
    private String name;
    private String description;
    private ArrayList<Case> case_list;
    private ArrayList<User> user_list;
    private Timestamp create_time;
    private Timestamp update_time;

    public Map toMap() throws IllegalArgumentException, IllegalAccessException{
        Map<String, Object> map = new HashMap<String, Object>();
        Field[] fields = this.getClass().getDeclaredFields();
        for(Field field:fields){
            field.setAccessible(true);
            map.put(field.getName(), field.get(this));
        }
        //map.put相当于request.setAttribute方法
        return map;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTest_progress() {
        return test_progress;
    }

    public void setTest_progress(int test_progress) {
        this.test_progress = test_progress;
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

    public ArrayList<Case> getCase_list() {
        return case_list;
    }

    public void setCase_list(ArrayList<Case> case_list) {
        this.case_list = case_list;
    }

    public ArrayList<User> getUser_list() {
        return user_list;
    }

    public void setUser_list(ArrayList<User> user_list) {
        this.user_list = user_list;
    }

    public Timestamp getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Timestamp create_time) {
        this.create_time = create_time;
    }

    public Timestamp getUpdate_time() {
        return update_time;
    }

    public void setUpdate_time(Timestamp update_time) {
        this.update_time = update_time;
    }

    @Override
    public String toString() {
        return "ProjectStatistic{" +
                "id=" + id +
                ", test_progress=" + test_progress +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", case_list=" + case_list +
                ", user_list=" + user_list +
                ", create_time=" + create_time +
                ", update_time=" + update_time +
                '}';
    }
}