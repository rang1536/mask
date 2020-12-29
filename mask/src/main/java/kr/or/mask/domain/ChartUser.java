package kr.or.mask.domain;

public class ChartUser {
	private String olevel;
	private String id;
	private String d_no;
	private String name;
	private String parentid;
	private String d_date;
	private String d_jicname;
	private String d_cename;
	private String d_jiccode;						
	private String pv1;
	private String d_uid;
	//private String D_GRP_CD;
	//private String D_JICCODEP_NAME;
	private String left_result;
	private String right_result;
	public String getOlevel() {
		return olevel;
	}
	public void setOlevel(String olevel) {
		this.olevel = olevel;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getD_no() {
		return d_no;
	}
	public void setD_no(String d_no) {
		this.d_no = d_no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getParentid() {
		return parentid;
	}
	public void setParentid(String parentid) {
		this.parentid = parentid;
	}
	public String getD_date() {
		return d_date;
	}
	public void setD_date(String d_date) {
		this.d_date = d_date;
	}
	public String getD_jicname() {
		return d_jicname;
	}
	public void setD_jicname(String d_jicname) {
		this.d_jicname = d_jicname;
	}
	public String getD_cename() {
		return d_cename;
	}
	public void setD_cename(String d_cename) {
		this.d_cename = d_cename;
	}
	public String getD_jiccode() {
		return d_jiccode;
	}
	public void setD_jiccode(String d_jiccode) {
		this.d_jiccode = d_jiccode;
	}
	public String getPv1() {
		return pv1;
	}
	public void setPv1(String pv1) {
		this.pv1 = pv1;
	}
	public String getD_uid() {
		return d_uid;
	}
	public void setD_uid(String d_uid) {
		this.d_uid = d_uid;
	}
	
	public String getLeft_result() {
		return left_result;
	}
	public void setLeft_result(String left_result) {
		this.left_result = left_result;
	}
	public String getRight_result() {
		return right_result;
	}
	public void setRight_result(String right_result) {
		this.right_result = right_result;
	}
	@Override
	public String toString() {
		return "chartUser [olevel=" + olevel + ", id=" + id + ", d_no=" + d_no + ", name=" + name + ", parentid="
				+ parentid + ", d_date=" + d_date + ", d_jicname=" + d_jicname + ", d_cename=" + d_cename
				+ ", d_jiccode=" + d_jiccode + ", pv1=" + pv1 + ", d_uid=" + d_uid + ", left_result=" + left_result + ", right_result="
				+ right_result + "]";
	}
	
	
}
