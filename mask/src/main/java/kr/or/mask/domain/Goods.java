package kr.or.mask.domain;

public class Goods {
	private String goodsCode;
	private String goodsName;
	private String newPrice;
	private String rePrice;
	private String customerPrice;
	private String newPriceYn;
	private String regdate;
	private String regid;
	private String moddate;
	private String modid;
	
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
	public String getNewPrice() {
		return newPrice;
	}
	public void setNewPrice(String newPrice) {
		this.newPrice = newPrice;
	}
	public String getRePrice() {
		return rePrice;
	}
	public void setRePrice(String rePrice) {
		this.rePrice = rePrice;
	}
	public String getCustomerPrice() {
		return customerPrice;
	}
	public void setCustomerPrice(String customerPrice) {
		this.customerPrice = customerPrice;
	}
	public String getNewPriceYn() {
		return newPriceYn;
	}
	public void setNewPriceYn(String newPriceYn) {
		this.newPriceYn = newPriceYn;
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
		return "Goods [goodsCode=" + goodsCode + ", goodsName=" + goodsName + ", newPrice=" + newPrice + ", rePrice="
				+ rePrice + ", customerPrice=" + customerPrice + ", newPriceYn=" + newPriceYn + ", regdate=" + regdate
				+ ", regid=" + regid + ", moddate=" + moddate + ", modid=" + modid + "]";
	}
	
}
