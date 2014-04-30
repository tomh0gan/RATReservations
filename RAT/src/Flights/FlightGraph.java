package Flights;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;

/*
 * Directed Graph. A Round Trip would between two cities would require two seperate edges. 
 */
public class FlightGraph {

	private LinkedList<FlightVertex>[] graph;
	private HashMap<String, Airport> map;
		
	public FlightGraph(ArrayList<FlightVertex> vertices, HashMap<String, Airport> map){
		graph = new LinkedList[vertices.size()];
		this.map = map;
		for(int i = 0; i < graph.length; i++){
			graph[i] = new LinkedList<FlightVertex>();
			graph[i].add(vertices.get(i));
		}
	}
	
	public String printVertices(){
		String x = "";
		for(int i = 0; i < graph.length; i++){
			x += graph[i].get(0).getAirport().getAirportName() + "\n";
		}
		return x;		
	}
	
	public String printEdges(){
		String y = "";
		/*for(int i = 0; i < graph.length; i++){
			LinkedList<FlightVertex> temp = graph[i];
			for(int j = 0; j < temp.size(); j++){
				y += temp.get(j).getAirport().getAirportName() + " ";
			}
		}
		return y;*/
		return graph[6].get(0).getIndex() + " to " + graph[6].get(1).getIndex();
	}
	
	public String addEdge(String depAirportId, String arrAirportId, FlightInfo info){
		int fromIndex = -1;
		int toIndex = -1;
		Airport depAirpot = map.get(depAirportId);
		Airport arrAirport = map.get(arrAirportId);
		for(int i = 0; i < graph.length; i++){
			if(graph[i].get(0).contains(depAirpot)){
				fromIndex = i;
			}
			if(graph[i].get(0).contains(arrAirport)){
				toIndex = i;
			}
		}
		if(fromIndex == -1 || toIndex == -1){
			return "Airport not found in graph. Edge "+depAirportId+"->"+arrAirportId+" cannot be inserted!";
		}
		FlightVertex fv = new FlightVertex(toIndex, arrAirport, info);
		graph[fromIndex].add(fv);
		return "Edge Added!"+depAirportId+"->"+arrAirportId;
	}
	
	public LinkedList<FlightVertex> getFlightPath(String start, String finish){
		LinkedList<FlightVertex> solution = new LinkedList<FlightVertex>();
		
		int startIndex = -1;
		int endIndex = -1;
		//Find starting point
		for(int i = 0; i < graph.length; i++){
			if(graph[i].get(0).getAirport().contains(start)){
				startIndex = i; //Starting point found.
			}
		}
		if(startIndex == -1){
			System.out.println("No starting place was found.");
			return null;
		}
		
		//BFS
		LinkedList<FlightVertex> queue = new LinkedList<FlightVertex>();
		boolean[] discovered = new boolean[graph.length];
		boolean[] processed = new boolean[graph.length];
		int[] parent = new int[graph.length];
		FlightVertex tempCurrent, tempTo;
		
		queue.add(graph[startIndex].get(0));
		discovered[startIndex] = true;
		while(!queue.isEmpty()){
			tempCurrent = queue.removeFirst();
			processed[tempCurrent.getIndex()] = true;
			int index = 1;
			if(graph[tempCurrent.getIndex()].size() == index){
				tempTo = null;
			}
			else{
				tempTo = graph[tempCurrent.getIndex()].get(index);
			}
			while(tempTo != null){
				index++;
				if(processed[tempTo.getIndex()] == false){
					//To do?
				}
				if(tempTo.getAirport().contains(finish) && endIndex == -1){
					endIndex = tempTo.getIndex();
				}
				if(discovered[tempTo.getIndex()] == false){
					queue.addLast(tempTo);
					discovered[tempTo.getIndex()] = true;
					parent[tempTo.getIndex()] = tempCurrent.getIndex();
				}
				if(graph[tempCurrent.getIndex()].size() == index){
					break;
				}
				else{
					tempTo = graph[tempCurrent.getIndex()].get(index);	
				}				
			}
			if(endIndex > 0){
				break;
			}
			
		}
		
		if(startIndex == endIndex){
			System.out.println("ERROR-start and end index are equal.");
			return null;
		}
		if(endIndex == -1){
			return null;
		}
		
		//Create Solution
		int tempIndex = endIndex;
		while(startIndex != tempIndex){
			solution.addFirst(graph[tempIndex].get(0));
			tempIndex = parent[tempIndex];
		}
		
		return solution;
	}
}
