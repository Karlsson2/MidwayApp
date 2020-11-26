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
      style: 'mapbox://styles/mapbox/streets-v10'
    });
    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
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
};

export { initMapbox };
