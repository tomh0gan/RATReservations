package Flights;

import java.util.ArrayList;

public class Res {
	private int id;
	private ArrayList<Res_Passenger> passengers;
	private double cost;
	
	public Res(int id){
		this.id = id;
		passengers = new ArrayList<Res_Passenger>();
	}
	
	public int getId() { return id; }
	public void setId(int id) { this.id = id; }
	
	public ArrayList<Res_Passenger> getPassengers() { return passengers; }
	public void setPassengers(ArrayList<Res_Passenger> passengers) { this.passengers = passengers; }

	public double getCost() { return cost; }
	public void setCost(double cost) { this.cost = cost; }
	
}
