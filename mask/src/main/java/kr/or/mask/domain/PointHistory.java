package kr.or.mask.domain;

public class PointHistory {
	private String no;
	private String id;
	private String type;
	private String point;
	private String message;
	private String regdate;
	
	public String getNo() {
		return no;
	}
	
	public void setNo(String no) {
		this.no = no;
	}
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getType() {
		return type;
	}
	
	public void setType(String type) {
		this.type = type;
	}
	
	public String getPoint() {
		return point;
	}
	public void setPoint(String point) {
		this.point = point;
	}
	
	public String getMessage() {
		return message;
	}
	
	public void setMessage(String message) {
		this.message = message;
	}
	
	public String getRegdate() {
		return regdate;
	}
	
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	@Override
	public String toString() {
		return "PointHistory [no=" + no + ", id=" + id + ", type=" + type + ", point=" + point + ", message=" + message
				+ ", regdate=" + regdate + "]";
	}
	
}
