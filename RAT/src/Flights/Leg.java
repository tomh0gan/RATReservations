package Flights;

public class Leg {

	private String airlineId;
	private String flightNum;
	private String legNum;
	private String depAirportId;
	private String arrAirportId;
	private String depTime;
	private String arrTime;
	private double baseFare;
	
	public Leg(String airlineId, String flightNum, String legNum, String depAirportId, String arrAirportId, String depTime, String arrTime, double baseFare){
		this.airlineId = airlineId;
		this.flightNum = flightNum;
		this.legNum = legNum;
		this.depAirportId = depAirportId;
		this.arrAirportId = arrAirportId;
		this.depTime = depTime;
		this.arrTime = depTime;
		this.baseFare = baseFare;
	}
	
	public String getAirlineId(){ return airlineId; }
	public void setAirlineId(String airlineId){ this.airlineId = airlineId; }
	
	public String getFlightNum(){ return flightNum; }
	public void setFlightNum(String flightNum){ this.flightNum = flightNum; }
	
	public String getLegNum(){ return legNum; }
	public void setLegNum(String legNum){ this.legNum = legNum; }
	
	public String getDepAirportId(){ return depAirportId; }
	public void setDepAirportId(String depAirportId){ this.depAirportId = depAirportId; }
	
	public String getArrAirportId(){ return arrAirportId; }
	public void setArrAirportId(String arrAirportId){ this.arrAirportId = arrAirportId; }
	
	public String getDepTime(){ return depTime; }
	public void setDepTime(String depTime){ this.depTime = depTime; }
	
	public String getArrTime(){ return arrTime; }
	public void setArrTime(String arrTime){ this.arrTime = arrTime; }
	
	public double getBaseFare(){ return baseFare; }
	public void setBaseFare(double baseFare){ this.baseFare = baseFare; }
	
}
