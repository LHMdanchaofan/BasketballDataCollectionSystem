package basketball.model;
import java.util.Date;
import basketball.util.DateUtil;

import java.text.ParseException;
import java.text.SimpleDateFormat;

public class SearchTrain {
	 private String stuId;
	 private String stuname;
	 private String coaname;
	 private String clubname;
	 private String begintime;
	 private String endtime;
     private Double beginshuttlerun;
     private Double endshuttlerun;
     private Double beginbenchpress;
     private Double endbenchpress;
     private Double begin50meters;
     private Double end50meters;
	 private Double begin1000meters;
     private Double end1000meters;
     private Double beginsetshot;
     private Double endsetshot;
	public SearchTrain() {
		super();
	}
	public String getBegintime() {
		return begintime;
	}
	public void setBegintime(String begintime){
        this.begintime = begintime;
}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime=endtime;
	}
	public Double getBeginshuttlerun() {
		return beginshuttlerun;
	}
	public void setBeginshuttlerun(Double beginshuttlerun) {
		this.beginshuttlerun = beginshuttlerun;
	}
	public Double getEndshuttlerun() {
		return endshuttlerun;
	}
	public void setEndshuttlerun(Double endshuttlerun) {
		this.endshuttlerun = endshuttlerun;
	}
	public Double getBeginbenchpress() {
		return beginbenchpress;
	}
	public void setBeginbenchpress(Double beginbenchpress) {
		this.beginbenchpress = beginbenchpress;
	}
	public Double getEndbenchpress() {
		return endbenchpress;
	}
	public void setEndbenchpress(Double endbenchpress) {
		this.endbenchpress = endbenchpress;
	}
	public Double getBegin50meters() {
		return begin50meters;
	}
	public void setBegin50meters(Double begin50meters) {
		this.begin50meters = begin50meters;
	}
	public Double getEnd50meters() {
		return end50meters;
	}
	public void setEnd50meters(Double end50meters) {
		this.end50meters = end50meters;
	}
	public Double getBegin1000meters() {
		return begin1000meters;
	}
	public void setBegin1000meters(Double begin1000meters) {
		this.begin1000meters = begin1000meters;
	}
	public Double getEnd1000meters() {
		return end1000meters;
	}
	public void setEnd1000meters(Double end1000meters) {
		this.end1000meters = end1000meters;
	}
	public Double getBeginsetshot() {
		return beginsetshot;
	}
	public void setBeginsetshot(Double beginsetshot) {
		this.beginsetshot = beginsetshot;
	}
	public Double getEndsetshot() {
		return endsetshot;
	}
	public void setEndsetshot(Double endsetshot) {
		this.endsetshot = endsetshot;
	}
	public String getStuId() {
		return stuId;
	}
	public void setStuId(String stuId) {
		this.stuId = stuId;
	}
	public String getStuname() {
		return stuname;
	}
	public void setStuname(String stuname) {
		this.stuname = stuname;
	}
	public String getCoaname() {
		return coaname;
	}
	public void setCoaname(String coaname) {
		this.coaname = coaname;
	}
	public String getClubname() {
		return clubname;
	}
	public void setClubname(String clubname) {
		this.clubname = clubname;
	}
     
}
