package basketball.model;

public class DataChart {
    private String begintime;
    private String endtime;
    private String project;
    private String projectcn;
    private String size;
    public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public String getProjectcn() {
		return projectcn;
	}
	public void setProjectcn(String projectcn) {
		this.projectcn = projectcn;
	}
	private String measure;
    
	public String getMeasure() {
		return measure;
	}
	public void setMeasure(String measure) {
		this.measure = measure;
	}
	public DataChart() {
		super();
	}
	public String getBegintime() {
		return begintime;
	}
	public void setBegintime(String begintime) {
		this.begintime = begintime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public String getProject() {
		return project;
	}
	public void setProject(String project) {
		this.project = project;
	}
    
}
