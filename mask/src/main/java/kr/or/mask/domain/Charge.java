package kr.or.mask.domain;

public class Charge {
	private String seq;
	private String id;
	private String point;
	private String phone;
	private String status;
	private String regdate;
	private String regid;
	private String moddate;
	private String modid;
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPoint() {
		return point;
	}
	public void setPoint(String point) {
		this.point = point;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getRegid() {
		return regid;
	}
	public void setRegid(String regid) {
		this.regid = regid;
	}
	public String getModdate() {
		return moddate;
	}
	public void setModdate(String moddate) {
		this.moddate = moddate;
	}
	public String getModid() {
		return modid;
	}
	public void setModid(String modid) {
		this.modid = modid;
	}
	
	@Override
	public String toString() {
		return "Charge [seq=" + seq + ", id=" + id + ", point=" + point + ", phone=" + phone + ", status=" + status
				+ ", regdate=" + regdate + ", regid=" + regid + ", moddate=" + moddate + ", modid=" + modid + "]";
	}
	
}
