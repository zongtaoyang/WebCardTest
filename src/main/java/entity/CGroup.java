package entity;

import java.lang.reflect.Field;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

public class CGroup {
	private int id;
	private String name;
	private String group_id;
	private Timestamp ctime;
	private Timestamp utime;
	
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

	public Timestamp getCtime() {
		return ctime;
	}

	public void setCtime(Timestamp ctime) {
		this.ctime = ctime;
	}

	public Timestamp getUtime() {
		return utime;
	}

	public void setUtime(Timestamp utime) {
		this.utime = utime;
	}

	public String getGroup_id() {
		return group_id;
	}

	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}
}
