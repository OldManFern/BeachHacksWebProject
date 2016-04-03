<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>My Travel Buddie</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/directions.css" rel="stylesheet" type="text/css">
  </head>
  <body>
    <center> 
    <div class="well"><h1> My Travel Buddie</h1><h2> Have A Save Trip</h2></div>
    </center>
    <div class= "row">
    <div class = "col-md-12">
    <div class = "col-md-6" id="right-panel"><center><h4>You Are <%= (String)request.getAttribute("transit") %>.</h4></center></div>
    <div class = "col-md-6" id="map" style="width:700px; height:500px"></div>
    </div>
	</div>
    <script>
		
      function initMap() {
    	  var directionsService = new google.maps.DirectionsService;
          var directionsDisplay = new google.maps.DirectionsRenderer;
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 13,
          center: {lat: <%= (String)request.getAttribute("lad") %>, lng:  <%= (String)request.getAttribute("lng") %>}
        });
        directionsDisplay.setMap(map);
        directionsDisplay.setPanel(document.getElementById('right-panel'));

        calculateAndDisplayRoute(directionsService, directionsDisplay);
      }

      function calculateAndDisplayRoute(directionsService, directionsDisplay) {
        var waypts = [];
        var checkboxArray = [<%= (String)request.getAttribute("array") %> ];
        for (var i = 0; i < checkboxArray.length; i++) {
            waypts.push({
              location: checkboxArray[i],
              stopover: true
            });
          }
        

        directionsService.route({
          origin: '<%= (String)request.getAttribute("location") %>',
          destination: '<%= (String)request.getAttribute("location") %>',
          waypoints: waypts,
          optimizeWaypoints: true,
          travelMode: google.maps.TravelMode.<%= (String)request.getAttribute("transit") %>
        }, function(response, status) {
          if (status === google.maps.DirectionsStatus.OK) {
            directionsDisplay.setDirections(response);
            
            
          } else {
            window.alert('Directions request failed due to ' + status);
          }
        });
        
      }
      
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDPHLNNxnhFFJF4jPLb_zfCW52vv4y24Tw&callback=initMap">
    </script>
  </body>
</html>