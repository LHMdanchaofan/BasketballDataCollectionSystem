package basketball.model;

public class User {
	private int Id;
    private String userName;
    private String passWord;
    private int identity; 
    private int apply;
	public User() {
		super();
	}
	
	public User(int id, String userName, String passWord, int identity) {
		super();
		this.Id = id;
		this.userName = userName;
		this.passWord = passWord;
		this.identity = identity;
	}

	public int getId() {
		return Id;
	}
	public void setId(int id) {
		Id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassWord() {
		return passWord;
	}
	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}
	public int getIdentity() {
		return identity;
	}
	public void setIdentity(int identity) {
		this.identity = identity;
	}

	public int getApply() {
		return apply;
	}
	public void setApply(int apply) {
		this.apply = apply;
	}
     
}
