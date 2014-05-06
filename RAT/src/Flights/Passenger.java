package Flights;

public class Passenger {

	private String resrNum;
	private String passengerId;
	private String name;
	private double total;
	
	public Passenger(String resrNum, String passengerId, String name, double total){
		this.resrNum = resrNum;
		this.passengerId = passengerId;
		this.name = name;
		this.total = total;
	}
	
	public String getResrNum(){ return resrNum; }
	public void setResrNum(String resrNum){ this.resrNum = resrNum; }
	
	public String getPassengerId(){ return passengerId; }
	public void setPassengerId(String passengerId){ this.passengerId = passengerId; }
	
	public String getName(){ return name; }
	public void setName(String name){ this.name = name; }
	
	public double getTotal(){ return total; }
	public void setTotal(double total){ this.total = total; }
}
