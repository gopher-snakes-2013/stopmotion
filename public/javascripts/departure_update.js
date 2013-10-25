$(document).ready(function(){
    setInterval(update_minutes_until_arrival, 5000);
});

var update_minutes_until_arrival = function(){
  $.ajax({
    url: "/update"
  }).done(function(response){
    update_all_oubtound_routes_departure_minutes(response);
  });
};


var update_all_oubtound_routes_departure_minutes = function(route_next_two_arrivals){
  route_next_two_arrivals = $.parseJSON(route_next_two_arrivals)
  j_next = route_next_two_arrivals[0]["arrival1"];
  j_next2 = route_next_two_arrivals[0]["arrival2"];
  k_next = route_next_two_arrivals[1]["arrival1"];
  k_next2 = route_next_two_arrivals[1]["arrival2"];
  l_next = route_next_two_arrivals[2]["arrival1"];
  l_next2 = route_next_two_arrivals[2]["arrival2"];
  m_next = route_next_two_arrivals[3]["arrival1"];
  m_next2 = route_next_two_arrivals[3]["arrival2"];
  n_next = route_next_two_arrivals[4]["arrival1"];
  n_next2 = route_next_two_arrivals[4]["arrival2"];
  $('td').eq(1).html(j_next);
  $('td').eq(2).html(j_next2);
  $('td').eq(4).html(k_next);
  $('td').eq(5).html(k_next2);
  $('td').eq(7).html(l_next);
  $('td').eq(8).html(l_next2);
  $('td').eq(10).html(m_next);
  $('td').eq(11).html(m_next2);
  $('td').eq(13).html(n_next);
  $('td').eq(14).html(n_next2);
}