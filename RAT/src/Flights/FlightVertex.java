package Flights;
import Flights.Airport;
import Flights.FlightInfo;

public class FlightVertex{
	private int index;
	private Airport airport;
	private FlightInfo flightInfo;
	
	public FlightVertex(int index, Airport airport, FlightInfo flightInfo){
		this.index = index;
		this.airport = airport;
		this.flightInfo = flightInfo;
	}
	
	public int getIndex(){ return index; }
	public FlightInfo getFlightInfo(){ return flightInfo; }
	public Airport getAirport(){ return airport; }
	public boolean contains(Airport ap){
		return airport.isEqual(ap);
	}
}
