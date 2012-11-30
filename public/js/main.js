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

function time() {
  var today=new Date();
  var h=today.getHours();
  var m=today.getMinutes();

  // add a zero in front of numbers<10
  if (m < 10) { m="0" + m; }
  if (h < 10) { h="0" + h; }

  $('.clock').html(h + ":" + m);
  t = setTimeout(function() { time(); }, 500);
}

weather();
time();
