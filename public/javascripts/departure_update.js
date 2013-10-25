$(document).ready(function(){
    setInterval(update_minutes_until_arrival, 15000);
});

var update_minutes_until_arrival = function(){
  $.ajax({
    url: "/update"
  }).done(function(response){
    console.log("zee sucks");
  $('td').eq(1).html(response);
  });
};