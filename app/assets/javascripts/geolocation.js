function get_location() {
  navigator.geolocation.getCurrentPosition(setLocations);
}

function setLocations(position) {
  var latitude = position.coords.latitude;
  var longitude = position.coords.longitude;
  var cookie_val = position.coords.latitude + "|" + position.coords.longitude;
  document.cookie = "lat_lng=" + escape(cookie_val);
}
