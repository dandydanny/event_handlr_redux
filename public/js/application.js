$(document).ready(function() {




// add a row of input fields to make new events with
console.log("Document ready fn");


  $("#addmoreeventbutton").click(function(event){
    console.log("addmoreeventbutton clicked");
    event.preventDefault();
    $(".addmoreevent").append('<table><tr><td><input id="textfield" type="text" name="name" placeholder="EVENT NAME"></td><td><input id="textfield" type="text" name="location" placeholder="LOCATION"></td><td><input id="textfield" type="text" name="starts_at" placeholder="START (Thu, 14 Nov 2013 10:57:25)"></td><td><input id="textfield" type="text" name="ends_at" placeholder="END (Thu, 14 Nov 2013 10:57:25)"></td><td><input id="saveeventbutton" type="submit" value="Save"></td></tr></table>');
  });

  $("#addmoreeventbutton").click(function() {
     event.preventDefault();
     $.post( "/addevent", $( "#addeventform" ).serialize() );
   });

  });




