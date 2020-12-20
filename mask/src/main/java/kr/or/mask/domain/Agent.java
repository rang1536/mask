package kr.or.mask.domain;

public class Agent {
	private String code;
	private String name;
	private String regdate;
	private String regid;
	private String moddate;
	private String modid;
	
	public String getCode() {
		return code;
	}
	
	public void setCode(String code) {
		this.code = code;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
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
		return "Agent [code=" + code + ", name=" + name + ", regdate=" + regdate + ", regid=" + regid + ", moddate="
				+ moddate + ", modid=" + modid + "]";
	}

}
