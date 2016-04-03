package beachhackswebproject;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class TravelBuddy
 */
@WebServlet("/TravelBuddie")
public class TravelBuddy extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TravelBuddy() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		if(request.getParameter("visited")!=null){
		
		
			
			
			String transit = request.getParameter("mode");
			request.setAttribute("transit", transit);
			String loc = request.getParameter("hidden");
			String part1;
			String part2;
			String ladd;
			String lngg;
			int index;
			int ladIndex;
			int count=0;
			
			String parsed="";
			String fullQuery;
			String queryStart = "http://maps.googleapis.com/maps/api/directions/json?";
			//origin=Adelaide,SA&destination=Adelaide,SA&waypoints=optimize:true|Barossa+Valley,SA|Clare,SA|Connawarra,SA|McLaren+Vale,SA";
			String queryEnd ="&key=AIzaSyDutIrWiUK80dt1ozZyTSncYLSdChqcvBs";
			
			index = loc.indexOf(";");
			part1 = loc.substring(0, index);
			part2 = loc.substring(index+2);
			
			ladIndex = part1.indexOf(",");
			ladd = part1.substring(0, ladIndex-1);
			lngg = part1.substring(ladIndex+2);
			request.setAttribute("lad", ladd);
			request.setAttribute("lng", lngg);
			request.setAttribute("location", part1);
		
			
			while(part2.contains(";")){
				index = part2.indexOf(";");
				part1 = part2.substring(0, index-1);
				
				try{
				part2 = part2.substring(index+2);
				parsed = parsed+"\""+part1+"\",";
				
				}catch(IndexOutOfBoundsException e){
					parsed = parsed+"\""+part1+"\"";
					break;
				}
				
			}
			
			index = parsed.length() -1;
			parsed =parsed.substring(0,index)+"\"";
			request.setAttribute("array", parsed);
			
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/DirectionsJSP");
			dispatcher.forward(request,response);
			
		}
		else {
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/TravelBuddieJSP");
		
		dispatcher.forward(request,response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	

}
