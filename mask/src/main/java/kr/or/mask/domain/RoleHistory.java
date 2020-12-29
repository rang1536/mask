package kr.or.mask.domain;

public class RoleHistory {
	private int seq;
	private String fromId;
	private String toId;
	private int type;
	private String regdate;
	private int amt;
	private int status;
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getFromId() {
		return fromId;
	}
	public void setFromId(String fromId) {
		this.fromId = fromId;
	}
	public String getToId() {
		return toId;
	}
	public void setToId(String toId) {
		this.toId = toId;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getAmt() {
		return amt;
	}
	public void setAmt(int amt) {
		this.amt = amt;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "RoleHistory [seq=" + seq + ", fromId=" + fromId + ", toId=" + toId + ", type=" + type + ", regdate="
				+ regdate + ", amt=" + amt + ", status=" + status + "]";
	}
	
	
}
