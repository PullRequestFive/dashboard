function weather() {
  navigator.geolocation.getCurrentPosition(function(data) {
    loc = data.coords.latitude + "," + data.coords.longitude
    var url = "/weather?location=" + loc;
    jQuery.get(url, function(data) {
      console.log(data);
      $('.f').html(data.temp);
    });
  });
}

weather();
