package entity;

import java.lang.reflect.Field;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

public class Project {
	private int id;
	private String name;
	private String description;
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

	public Timestamp getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Timestamp update_time) {
		this.update_time = update_time;
	}
}
