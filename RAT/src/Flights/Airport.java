package Flights;

public class Airport{
	private String airportName;
	private String airportCity;
	
	public Airport(String airportName, String airportCity){
		this.airportName = airportName;
		this.airportCity = airportCity;
	}
	
	public String getAirportName(){ return airportName; }
	public String getAirportCity(){ return airportCity; }
	public boolean isEqual(Airport airport){
		if(airport.getAirportCity().equals(airportCity) && airport.getAirportName().equals(airportName)) return true;
		return false;
	}
	public boolean contains(String place){
		if(place.equals(airportCity) || place.equals(airportName)) return true;
		return false;
	}
}
