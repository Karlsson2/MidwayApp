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

      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

      const marker_element = document.createElement('div');
        marker_element.className = 'marker_element';
        marker_element.style.backgroundImage = `url('${marker.image_url}')`;
        marker_element.style.backgroundSize = 'contain';
        marker_element.style.width = '25px';
        marker_element.style.height = '25px';

      new mapboxgl.Marker(marker_element)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(map);
    });
    const midpoint = JSON.parse(mapElement.dataset.midpoint);

    const midpoint_marker = document.createElement('div');
      midpoint_marker.className = 'midpoint_marker';
      midpoint_marker.style.backgroundImage = `url('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTTqgTjUQdutxymPxna3podsnrbxBe5HYpNA&usqp=CAU')`;
      midpoint_marker.style.backgroundSize = 'contain';
      midpoint_marker.style.width = '25px';
      midpoint_marker.style.height = '25px';

    new mapboxgl.Marker(midpoint_marker)
        .setLngLat([ midpoint.lng, midpoint.lat ])
        .addTo(map);
    fitMapToMarkers(map, markers);
  }



// map for show page below




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
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(map);
    });
    const midpoint = JSON.parse(mapElementShow.dataset.midpoint);

      // var el = document.createElement("div");
      // el.className = 'marker';
      // we are trying to style the midpoint marker

    new mapboxgl.Marker()
        .setLngLat([ midpoint.lng, midpoint.lat ])
        .addTo(map);
    fitMapToMarkers(map, markers);

    const venue = JSON.parse(mapElementShow.dataset.venue);

      // var el = document.createElement("div");
      // el.className = 'marker';
      // we are trying to style the venue marker

    new mapboxgl.Marker()
        .setLngLat([ venue.lng, venue.lat ])
        .addTo(map);
    fitMapToMarkers(map, markers);
  }
};

export { initMapbox };