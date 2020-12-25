package kr.or.mask.domain;

public class PointHistory {
	private String no;
	private String id;
	private String type;
	private String point;
	private String message;
	private String fromId;
	private String toId;
	private String regdate;

	//검색을 위한 컬럼
	private String searchFromDate;
	private String searchToDate;
	private int beginIdx;
	private int searchRows;
	private String searchType;
	private String searchValue;
	
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
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getSearchFromDate() {
		return searchFromDate;
	}
	public void setSearchFromDate(String searchFromDate) {
		this.searchFromDate = searchFromDate;
	}
	public String getSearchToDate() {
		return searchToDate;
	}
	public void setSearchToDate(String searchToDate) {
		this.searchToDate = searchToDate;
	}
	public int getBeginIdx() {
		return beginIdx;
	}
	public void setBeginIdx(int beginIdx) {
		this.beginIdx = beginIdx;
	}
	public int getSearchRows() {
		return searchRows;
	}
	public void setSearchRows(int searchRows) {
		this.searchRows = searchRows;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getSearchValue() {
		return searchValue;
	}
	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}
	@Override
	public String toString() {
		return "PointHistory [no=" + no + ", id=" + id + ", type=" + type + ", point=" + point + ", message=" + message
				+ ", fromId=" + fromId + ", toId=" + toId + ", regdate=" + regdate + ", searchFromDate="
				+ searchFromDate + ", searchToDate=" + searchToDate + ", beginIdx=" + beginIdx + ", searchRows="
				+ searchRows + ", searchType=" + searchType + ", searchValue=" + searchValue + "]";
	}

}
