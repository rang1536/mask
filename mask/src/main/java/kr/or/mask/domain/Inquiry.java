package kr.or.mask.domain;

public class Inquiry {
	private String seq;
	private String contents;
	private String status;
	private String answer;
	private String regid;
	private String regdate;
	private String ansid;
	private String ansdate;
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getRegid() {
		return regid;
	}
	public void setRegid(String regid) {
		this.regid = regid;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getAnsid() {
		return ansid;
	}
	public void setAnsid(String ansid) {
		this.ansid = ansid;
	}
	public String getAnsdate() {
		return ansdate;
	}
	public void setAnsdate(String ansdate) {
		this.ansdate = ansdate;
	}
	
	@Override
	public String toString() {
		return "Inquiry [seq=" + seq + ", contents=" + contents + ", status=" + status + ", answer=" + answer
				+ ", regid=" + regid + ", regdate=" + regdate + ", ansid=" + ansid + ", ansdate=" + ansdate + "]";
	}


}
