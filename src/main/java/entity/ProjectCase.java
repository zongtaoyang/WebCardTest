package entity;

import java.lang.reflect.Field;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

public class ProjectCase {
	private int id;
	private int project_id;
	private int case_id;
	private Timestamp create_time;
	
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

	public Timestamp getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Timestamp create_time) {
		this.create_time = create_time;
	}
}
