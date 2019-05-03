package com.javaex.vo;

import java.sql.Date;

public class CategoryVo {
	private int CATENO;
	private String ID;
	private String CATENAME;
	private String DESCRIPTION;
	private Date REGDATE;
	private int POSTCNT;
	

	public CategoryVo() {
	}

	public CategoryVo(int cATENO, String iD, String cATENAME, String dESCRIPTION, Date rEGDATE, int pOSTCNT) {
		super();
		CATENO = cATENO;
		ID = iD;
		CATENAME = cATENAME;
		DESCRIPTION = dESCRIPTION;
		REGDATE = rEGDATE;
		POSTCNT = pOSTCNT;
	}
	
	

	public int getPOSTCNT() {
		return POSTCNT;
	}

	public void setPOSTCNT(int pOSTCNT) {
		POSTCNT = pOSTCNT;
	}

	public int getCATENO() {
		return CATENO;
	}
	public void setCATENO(int cATENO) {
		CATENO = cATENO;
	}
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getCATENAME() {
		return CATENAME;
	}
	public void setCATENAME(String cATENAME) {
		CATENAME = cATENAME;
	}
	public String getDESCRIPTION() {
		return DESCRIPTION;
	}
	public void setDESCRIPTION(String dESCRIPTION) {
		DESCRIPTION = dESCRIPTION;
	}
	public Date getREGDATE() {
		return REGDATE;
	}
	public void setREGDATE(Date rEGDATE) {
		REGDATE = rEGDATE;
	}

	@Override
	public String toString() {
		return "CategoryVo [CATENO=" + CATENO + ", ID=" + ID + ", CATENAME=" + CATENAME + ", DESCRIPTION=" + DESCRIPTION
				+ ", REGDATE=" + REGDATE + ", POSTCNT=" + POSTCNT + "]";
	}


	
	
	
}
