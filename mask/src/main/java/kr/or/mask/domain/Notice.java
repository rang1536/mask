package kr.or.mask.domain;

public class Notice {
	private int seq;
	private String title;
	private String regId;
	private String regDate;
	private int selCnt;
	private String contents;
	private int type;
	
	
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public int getSelCnt() {
		return selCnt;
	}
	public void setSelCnt(int selCnt) {
		this.selCnt = selCnt;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	@Override
	public String toString() {
		return "Notice [seq=" + seq + ", title=" + title + ", regId=" + regId + ", regDate=" + regDate + ", selCnt="
				+ selCnt + ", contents=" + contents + ", type=" + type + "]";
	}
	
	
	
}
