$(document).ready(function(){
  console.log("loaded here");
  var ajax_update = $.ajax({
    url: "/update"
  }).done(function(response){
    // $('tr').eq(3).html(response);
    console.log(response);
  });

  // var flag = 0
  // function update_departure_time (){
  //   console.log(flag);
  //   flag +=1
  // }

  setInterval(ajax_update, 3000);

});