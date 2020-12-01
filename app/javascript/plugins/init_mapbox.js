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

      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(map);
    });
    const midpoint = JSON.parse(mapElement.dataset.midpoint);

      // var el = document.createElement("div");
      // el.className = 'marker';
      // we are trying to style the midpoint marker

    new mapboxgl.Marker()
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
