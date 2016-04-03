<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>My Travel Buddie</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/travelbuddie.css" rel="stylesheet" type="text/css">

</head>

<body>

  <center> <div class= "well"> <h1> My Travel Buddie</h1> <h3>Please Find All Locations You Need To Go To</h3><h3>Then Hit Submit</h3>
    
   </div>  
<form action="" method="post">
<input id="pac-input" class="controls" type="text"
        placeholder="Enter a location">
    <div id="type-selector" class="controls">
      <input type="radio" name="type" id="changetype-all" checked="checked">
      <label for="changetype-all">All</label>

      <input type="radio" name="type" id="changetype-establishment">
      <label for="changetype-establishment">Establishments</label>

      <input type="radio" name="type" id="changetype-address">
      <label for="changetype-address">Addresses</label>
      
    <b>Transit: </b>
    <select id="mode" name="mode">
      <option selected="selected" value="DRIVING">Driving</option>
      <option value="WALKING">Walking</option>
      <option value="BICYCLING">Bicycling</option>
      <option value="TRANSIT">Transit</option>
    </select>
    
    </div>
       <div id="map" style="width:700px; height:500px"></div>
           
        <input type="hidden" name ="visited" value ="true"/>
        <input id="totalNum" type="hidden" value="0"/>
        <input id="hidden" type="hidden" name="hidden" value=""/>
        
 	<script>
      // This example requires the Places library. Include the libraries=places
      // parameter when you first load the API. For example:
      // <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">

      function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: 33.783875, lng: -118.116067},
          zoom: 13
        });
        var input = /** @type {!HTMLInputElement} */(
            document.getElementById('pac-input'));

        var types = document.getElementById('type-selector');
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(types);

        var autocomplete = new google.maps.places.Autocomplete(input);
        autocomplete.bindTo('bounds', map);

        var infowindow = new google.maps.InfoWindow();
        var marker = new google.maps.Marker({
          map: map,
          anchorPoint: new google.maps.Point(0, -29)
        });

        autocomplete.addListener('place_changed', function() {
          infowindow.close();
          marker.setVisible(false);
          var place = autocomplete.getPlace();
          if (!place.geometry) {
            window.alert("Autocomplete's returned place contains no geometry");
            return;
          }

          // If the place has a geometry, then present it on a map.
          if (place.geometry.viewport) {
            map.fitBounds(place.geometry.viewport);
          } else {
            map.setCenter(place.geometry.location);
            map.setZoom(17);  // Why 17? Because it looks good.
          }
          marker.setIcon(/** @type {google.maps.Icon} */({
            url: place.icon,
            size: new google.maps.Size(71, 71),
            origin: new google.maps.Point(0, 0),
            anchor: new google.maps.Point(17, 34),
            scaledSize: new google.maps.Size(35, 35)
          }));
          marker.setPosition(place.geometry.location);
          marker.setVisible(true);

          var address = '';
          if (place.address_components) {
            address = [
              (place.address_components[0] && place.address_components[0].short_name || ''),
              (place.address_components[1] && place.address_components[1].short_name || ''),
              (place.address_components[2] && place.address_components[2].short_name || '')
            ].join(', ');
			
          }
          var geocoder = new google.maps.Geocoder();

          infowindow.setContent('<div><strong>' + place.name + '</strong><br/>' + address+'</div>');
          geocodeAddress(geocoder, address);
          infowindow.open(map, marker);
        });

        // Sets a listener on a radio button to change the filter type on Places
        // Autocomplete.
        function setupClickListener(id, types) {
          var radioButton = document.getElementById(id);
          radioButton.addEventListener('click', function() {
            autocomplete.setTypes(types);
          });
        }

        setupClickListener('changetype-all', []);
        setupClickListener('changetype-address', ['address']);
        setupClickListener('changetype-establishment', ['establishment']);
      
	  var infoWindow = new google.maps.InfoWindow({map: map});

        // Try HTML5 geolocation
		
		
        if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(function(position) {
            var pos = {
              lat: position.coords.latitude,
              lng: position.coords.longitude
            };
            
            infoWindow.setPosition(pos);
            infoWindow.setContent('Your Current Location');
            var gff = document.getElementById("hidden").value;
      	 	 gff = gff +pos.lat+","+pos.lng +';';
      	 	document.getElementById("hidden").value = gff;
      	 	alert("Your Start Location Has Been Added");
            map.setCenter(pos);
          }, function() {
            handleLocationError(true, infoWindow, map.getCenter());
          });
        } else {
          // Browser doesn't support Geolocation
          handleLocationError(false, infoWindow, map.getCenter());
        }
		
        

		
	  }
	        function handleLocationError(browserHasGeolocation, infoWindow, pos) {
        infoWindow.setPosition(pos);
        infoWindow.setContent(browserHasGeolocation ?
                              'Error: The Geolocation service failed.' :
                              'Error: Your browser doesn\'t support geolocation.');
      }
	        function geocodeAddress(geocoder, address) {
	            
	            geocoder.geocode({'address': address}, function(results, status) {
	            	
	              if (status === google.maps.GeocoderStatus.OK) {
	            	  var gtf = document.getElementById("hidden").value;
	           	 	 gtf = gtf + results[0].geometry.location+';';
	           	 	document.getElementById("hidden").value = gtf;
	           	 	alert("Your Travel Location Has Been Added");
	                
	              } else {
	                alert('Geocode was not successful for the following reason: ' + status);
	              }
	            });
	          }
	               
	      </script>
     <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD5vkBG-MHiCAsRU9WPz548ZyG63C5vlNc&libraries=places&callback=initMap" async defer ></script> 
        <br/>
        

        <input type="submit" class="btn btn-primary"/>
        </form>

      </center>
</body>


</html>