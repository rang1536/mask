package kr.or.mask.domain;

public class User {
	private String id;
	private String pass;
	private String name;
	private String phone;
	private String zipcode;
	private String addr1;
	private String addr2;
	private String point;
	private String grade;
	private String deliveryZipcode;
	private String deliveryAddr1;
	private String deliveryAddr2;
	private String recommender;
	private String sponsor;
	private String agent;
	private String regdate;
	private String regid;
	private String moddate;
	private String modid;
	private String oriPass;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public String getPoint() {
		return point;
	}

	public void setPoint(String point) {
		this.point = point;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getDeliveryZipcode() {
		return deliveryZipcode;
	}

	public void setDeliveryZipcode(String deliveryZipcode) {
		this.deliveryZipcode = deliveryZipcode;
	}

	public String getDeliveryAddr1() {
		return deliveryAddr1;
	}

	public void setDeliveryAddr1(String deliveryAddr1) {
		this.deliveryAddr1 = deliveryAddr1;
	}

	public String getDeliveryAddr2() {
		return deliveryAddr2;
	}

	public void setDeliveryAddr2(String deliveryAddr2) {
		this.deliveryAddr2 = deliveryAddr2;
	}

	public String getRecommender() {
		return recommender;
	}

	public void setRecommender(String recommender) {
		this.recommender = recommender;
	}

	public String getSponsor() {
		return sponsor;
	}

	public void setSponsor(String sponsor) {
		this.sponsor = sponsor;
	}

	public String getAgent() {
		return agent;
	}

	public void setAgent(String agent) {
		this.agent = agent;
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

	public String getOriPass() {
		return oriPass;
	}

	public void setOriPass(String oriPass) {
		this.oriPass = oriPass;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", pass=" + pass + ", name=" + name + ", phone=" + phone + ", zipcode=" + zipcode
				+ ", addr1=" + addr1 + ", addr2=" + addr2 + ", point=" + point + ", grade=" + grade
				+ ", deliveryZipcode=" + deliveryZipcode + ", deliveryAddr1=" + deliveryAddr1 + ", deliveryAddr2="
				+ deliveryAddr2 + ", recommender=" + recommender + ", sponsor=" + sponsor + ", agent=" + agent
				+ ", regdate=" + regdate + ", regid=" + regid + ", moddate=" + moddate + ", modid=" + modid
				+ ", oriPass=" + oriPass + "]";
	}
	
}
