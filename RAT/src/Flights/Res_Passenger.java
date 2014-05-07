package Flights;

import java.util.ArrayList;

public class Res_Passenger {
	private int id;
	private ArrayList<Res_Leg> legs;
	
	public Res_Passenger(int id){
		this.id = id;
		setLegs(new ArrayList<Res_Leg>());
	}

	public int getId() { return id; }
	public void setId(int id) { this.id = id; }

	public ArrayList<Res_Leg> getLegs() { return legs; }
	public void setLegs(ArrayList<Res_Leg> legs) { this.legs = legs; }
	
	public double getCost() {
		double cost = 0;
		for(Res_Leg l : legs){
			cost += l.getCost();
		}
		return cost;
	}
	
}
