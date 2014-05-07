package Flights;

import java.util.ArrayList;

public class Res {
	private int id;
	private double bookingFee;
	private ArrayList<Res_Passenger> passengers;
	
	public Res(int id){
		this.id = id;
		passengers = new ArrayList<Res_Passenger>();
		this.bookingFee = -1;
	}
	
	public int getId() { return id; }
	public void setId(int id) { this.id = id; }
	
	public ArrayList<Res_Passenger> getPassengers() { return passengers; }
	public void setPassengers(ArrayList<Res_Passenger> passengers) { this.passengers = passengers; }

	public double getCost() {
		double cost = 0;
		for(Res_Passenger rp : passengers){
			cost += rp.getCost();
		}
		return cost;
	}
	
	public double getBookingFee(){ return bookingFee; }
	public void setBookingFee(double bookingFee){ this.bookingFee = bookingFee; }
}
