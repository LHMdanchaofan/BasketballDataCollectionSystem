package basketball.model;

/**
 * ”√ªßModel¿‡
 * @author www.java1234.com
 *
 */
public class Sortinfo {

	
	
	private String sort;
	private String order;
	public Sortinfo(String sort, String order) {
		super();
		this.sort = sort;
		this.order = order;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}

	
}
