import mapboxgl from 'mapbox-gl';

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  // does as it states, fits map to markers so not zoomed out
  const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  };

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: "mapbox://styles/hardhillon/cki61i7fr0y5j19mlquwwtx68"
    });
    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {


      var card = document.getElementById(`card-${marker.place_id}`);
      card.addEventListener("mouseover", function( event ) {
        marker_element.style.width = '52px';
        marker_element.style.height = '52px';
      })


      card.addEventListener("mouseout", function( event ) {
        marker_element.style.width = '32px';
        marker_element.style.height = '32px';
      })

      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

      // Markers styling
      const marker_element = document.createElement('div');

        marker_element.className = `'marker_element link-${marker.place_id}'`;
        marker_element.style.backgroundImage = `url('${marker.image_url}')`;
        marker_element.style.backgroundSize = 'contain';
        marker_element.style.width = '32px';
        marker_element.style.height = '32px';

      new mapboxgl.Marker(marker_element)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(map);
    });
    const midpoint = JSON.parse(mapElement.dataset.midpoint);
    console.log(midpoint)
    // Midpoint marker Styling
    const midpoint_marker = document.createElement('div');
      midpoint_marker.className = 'midpoint_marker';
      midpoint_marker.style.backgroundImage = `url('${midpoint.image}')`;
      midpoint_marker.style.backgroundSize = 'cover';
      midpoint_marker.style.width = '38px';
      midpoint_marker.style.height = '50px';

    new mapboxgl.Marker(midpoint_marker)
        .setLngLat([ midpoint.lng, midpoint.lat ])
        .addTo(map);
    fitMapToMarkers(map, markers);
  }



// MAP FOR SHOW PAGE




  const mapElementShow = document.getElementById('map-show');

  // does as it states, fits map to markers so not zoomed out
  const fitMapShowToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 10, duration: 0 });
  };

  if (mapElementShow) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElementShow.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map-show',
      style: 'mapbox://styles/hardhillon/cki61i7fr0y5j19mlquwwtx68'
    });
    const markers = JSON.parse(mapElementShow.dataset.markers);
    markers.forEach((marker) => {

      // Markers for PEOPLE
      const marker_element = document.createElement('div');
        marker_element.className = 'marker_element avatar';
        marker_element.style.backgroundImage = `url('${marker.image_url}')`;
        marker_element.style.backgroundSize = 'cover';
        marker_element.style.width = '52px';
        marker_element.style.height = '52px';

      new mapboxgl.Marker(marker_element)
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(map);
    });
    const midpoint = JSON.parse(mapElementShow.dataset.midpoint);

    // Midpoint marker styling
    const midpoint_marker = document.createElement('div');
      midpoint_marker.className = 'midpoint_marker';
      midpoint_marker.style.backgroundImage = `url('${midpoint.image}')`;
      midpoint_marker.style.backgroundSize = 'contain';
      midpoint_marker.style.width = '38px';
      midpoint_marker.style.height = '50px';

    new mapboxgl.Marker(midpoint_marker)
        .setLngLat([ midpoint.lng, midpoint.lat ])
        .addTo(map);
    fitMapToMarkers(map, markers);

    // VENUE MARKER
    const venue = JSON.parse(mapElementShow.dataset.venue);

    const venue_marker = document.createElement('div');
    // if statement to determine class
    if (venue.venue_type == 'bar'){
      venue_marker.className = 'venue_marker_pub';
    } else if (venue.venue_type == 'restaurant'){
      venue_marker.className = 'venue_marker_restaurant'
    }else if (venue.venue_type == 'movie_theater'){
      venue_marker.className = 'venue_marker_movie_theater'
    }else if (venue.venue_type == 'park'){
      venue_marker.className = 'venue_marker_park'
    }else if (venue.venue_type == 'art_gallery'){
      venue_marker.className = 'venue_marker_art_gallery'
    }else if (venue.venue_type == 'museum'){
      venue_marker.className = 'venue_marker_museum'
    }else if (venue.venue_type == 'night_club'){
      venue_marker.className = 'venue_marker_night_club'
    }else if (venue.venue_type == 'cafe'){
      venue_marker.className = 'venue_marker_cafe'
    }else if (venue.venue_type == 'bowling_alley'){
      venue_marker.className = 'venue_marker_bowling_alley'
    }else if (venue.venue_type == 'shopping_mall'){
      venue_marker.className = 'venue_marker_shopping_mall'
    }
      // old pin
      // venue_marker.style.backgroundImage = `url(${venue.pin})`;
      venue_marker.style.backgroundSize = 'contain';
      venue_marker.style.width = '25px';
      venue_marker.style.height = '25px';

    new mapboxgl.Marker(venue_marker)
        .setLngLat([ venue.lng, venue.lat ])
        .addTo(map);
    fitMapToMarkers(map, markers);
  }
};

export { initMapbox };
