package process;

public class ReturnObj {
	
	private Object data;
	private boolean success;
	private String msg;
	
	public ReturnObj() {
		super();
	}
	public ReturnObj(boolean success, String msg, Object data) {
		super();
		this.data = data;
		this.success = success;
		this.msg = msg;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
	
	public boolean isSuccess() {
		return success;
	}
	public void setSuccess(boolean success) {
		this.success = success;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	public static final boolean SUCCESS = true;
	
	public static final boolean FAIL = false;
	
	public static final String LOGIN_SUCCESS_MSG = "登录成功";
	public static final String LOGIN_FAIL_MSG = "登陆失败";
	
	public static final String SAVE_SUCCESS_MSG = "保存成功";
	public static final String SAVE_FAIL_MSG = "保存失败";
	
	public static final String ADD_SUCCESS_MSG = "添加成功";
	public static final String ADD_FAIL_MSG = "添加失败";
	
	public static final String UPDATE_SUCCESS_MSG = "更新成功";
	public static final String UPDATE_FAIL_MSG = "更新失败";
	
	public static final String SET_SUCCESS_MSG = "设置成功";
	public static final String SET_FAIL_MSG = "设置失败";
	
	public static final String DELETE_SUCCESS_MSG = "删除成功";
	public static final String DELETE_FAIL_MSG = "删除失败";
	
	public static final String DO_SUCCESS_MSG = "操作成功";
	public static final String DO_FAIL_MSG = "操作失败";
	
	
	
}
