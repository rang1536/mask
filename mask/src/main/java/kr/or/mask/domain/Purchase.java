package kr.or.mask.domain;

public class Purchase {
	private String code;
	private String goodsCode;
	private String goodsName;
	private String point;
	private String status;
	private String deliveryZipcode;
	private String deliveryAddr1;
	private String deliveryAddr2;
	private String deliveryCompany;
	private String deliveryCode;
	private String regdate;
	private String regid;
	private String moddate;
	private String modid;
	private String receiveName;
	private String receivePhone;
	
	// 분기를 위한 컬럼
	private String type;
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getGoodsCode() {
		return goodsCode;
	}
	public void setGoodsCode(String goodsCode) {
		this.goodsCode = goodsCode;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getPoint() {
		return point;
	}
	public void setPoint(String point) {
		this.point = point;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
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
	public String getDeliveryCompany() {
		return deliveryCompany;
	}
	public void setDeliveryCompany(String deliveryCompany) {
		this.deliveryCompany = deliveryCompany;
	}
	public String getDeliveryCode() {
		return deliveryCode;
	}
	public void setDeliveryCode(String deliveryCode) {
		this.deliveryCode = deliveryCode;
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
	public String getReceiveName() {
		return receiveName;
	}
	public void setReceiveName(String receiveName) {
		this.receiveName = receiveName;
	}
	public String getReceivePhone() {
		return receivePhone;
	}
	public void setReceivePhone(String receivePhone) {
		this.receivePhone = receivePhone;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	@Override
	public String toString() {
		return "Purchase [code=" + code + ", goodsCode=" + goodsCode + ", goodsName=" + goodsName + ", point=" + point
				+ ", status=" + status + ", deliveryZipcode=" + deliveryZipcode + ", deliveryAddr1=" + deliveryAddr1
				+ ", deliveryAddr2=" + deliveryAddr2 + ", deliveryCompany=" + deliveryCompany + ", deliveryCode="
				+ deliveryCode + ", regdate=" + regdate + ", regid=" + regid + ", moddate=" + moddate + ", modid="
				+ modid + ", receiveName=" + receiveName + ", receivePhone=" + receivePhone + ", type=" + type + "]";
	}
	
}
