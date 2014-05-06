package Flights;

public class ReservationLeg {
	private String resrNum;
	private String passengerId;
	private String airlineId;
	private String flightNum;
	private String legNum;
	private String depTime;
	private String flightClass;
	private String type;
	private String seatNum;
	private double total;
	
	
	public ReservationLeg(String resrNum, 
						  String passengerId, 
						  String airlineId, 
						  String flightNum, 
						  String legNum,
						  String depTime, 
						  String flightClass, 
						  String type,
						  String seatNum,
						  double total){
		
		this.resrNum = resrNum;
		this.passengerId = passengerId;
		this.airlineId = airlineId;
		this.flightNum = flightNum;
		this.legNum = legNum;
		this.depTime = depTime;
		this.flightClass = flightClass;
		this.type = type;
		this.seatNum = seatNum;
		this.total = total;
	}
	
	public String getResrNum(){ return resrNum; }
	public void setResrNum(String resrNum){ this.resrNum = resrNum; }
	
	public String getPassengerId(){ return passengerId; }
	public void setPassengerId(String passengerId){ this.passengerId = passengerId; }
	
	public String getAirlineId(){ return airlineId; }
	public void setAirlineId(String airlineId){ this.airlineId = airlineId; }
	
	public String getFlightNum(){ return flightNum; }
	public void setFlightNum(String flightNum){ this.flightNum = flightNum; }
	
	public String getLegNum(){ return legNum; }
	public void setLegNum(String legNum){ this.legNum = legNum; }
	
	public String getDepTime(){ return depTime; }
	public void setDepTime(String depTime){ this.depTime = depTime; }
	
	public String getFlightClass(){ return flightClass; }
	public void setFlightClass(String flightClass){ this.flightClass = flightClass; }
	
	public String getType(){ return type; }
	public void setType(String type){ this.type = type; }
	
	public String getSeatNum(){ return seatNum; }
	public void setSeatNum(String seatNum){ this.seatNum = seatNum; }
	
	public double getTotal(){ return total; }
	public void setTotal(double total){ this.total = total; }
	
}
