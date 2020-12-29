package kr.or.mask.domain;

public class DayClosing {
	private String userId;
	private String regdate;
	private int leftCnt;
	private int rightCnt;
	private int recommCnt;
	private String state;
	private String modDate;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getLeftCnt() {
		return leftCnt;
	}
	public void setLeftCnt(int leftCnt) {
		this.leftCnt = leftCnt;
	}
	public int getRightCnt() {
		return rightCnt;
	}
	public void setRightCnt(int rightCnt) {
		this.rightCnt = rightCnt;
	}
	public int getRecommCnt() {
		return recommCnt;
	}
	public void setRecommCnt(int recommCnt) {
		this.recommCnt = recommCnt;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getModDate() {
		return modDate;
	}
	public void setModDate(String modDate) {
		this.modDate = modDate;
	}
	@Override
	public String toString() {
		return "DayClosing [userId=" + userId + ", regdate=" + regdate + ", leftCnt=" + leftCnt + ", rightCnt="
				+ rightCnt + ", recommCnt=" + recommCnt + ", state=" + state + ", modDate=" + modDate + "]";
	}
	
	
}
