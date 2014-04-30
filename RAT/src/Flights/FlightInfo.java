package Flights;

public class FlightInfo{
	private String airlineId;
	private String flightNum;
	private String legNumber;
	
	public FlightInfo(String airlineId, String flightNum, String legNumber){
		this.airlineId = airlineId;
		this.flightNum = flightNum;
		this.legNumber = legNumber;
	}
	
	public String getAirlineId(){ return airlineId; }
	public String getFlightNum(){ return flightNum; }
	public String getLegNumber(){ return legNumber; }
}
