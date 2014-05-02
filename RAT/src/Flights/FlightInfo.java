package Flights;

public class FlightInfo{
	private String airlineId;
	private String flightNum;
	private String legNumber;
	
	private String departDate;
	private String arrivalDate;
	
	public FlightInfo(String airlineId, String flightNum, String legNumber, String departDate, String arrivalDate){
		this.airlineId = airlineId;
		this.flightNum = flightNum;
		this.legNumber = legNumber;
		this.departDate = departDate;
		this.arrivalDate = arrivalDate;
	}
	
	public String getAirlineId(){ return airlineId; }
	public String getFlightNum(){ return flightNum; }
	public String getLegNumber(){ return legNumber; }
	public String getDepartDate(){ return departDate; }
	public String getArrivalDate(){ return arrivalDate; }
}
