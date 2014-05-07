package Flights;

public class Res_Leg {
	private Leg l;
	private String lClass;
	private String lType;
	private int seatNum;
	private double cost;
	
	public Res_Leg(Leg l, String lClass, String lType, int seatNum){
		this.l = l;
		this.lClass = lClass;
		this.lType = lType;
		this.seatNum = seatNum;
	}
	
	public Leg getL() { return l; }
	public void setL(Leg l) { this.l = l; }
	
	public String getLType() { return lType; }
	public void setLType(String lType) { this.lType = lType; }
	
	public String getLClass() { return lClass; }
	public void setLClass(String lClass) { this.lClass = lClass; }

	public int getSeatNum() { return seatNum; }
	public void setSeatNum(int seatNum) { this.seatNum = seatNum; }

	public double getCost() { return cost; }
	public void setCost(double cost) { this.cost = cost; }
	
}
