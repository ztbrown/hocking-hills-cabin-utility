// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require private_pub
//= require bootstrap
//= require_tree .

var isOdd = false; 

var id = 0; 

  appendNewResult = function(title, description, rate, image) {

  	console.log(id);  

  	$('#loadingDiv').hide();

  	var oddEven = isOdd ? "odd" : "even"; 
  	isOdd = !isOdd; 

    $('.unstyled').append('<li class="' + oddEven + '"> <div class="imageContainer" id="image'+ id +'"></div> <div id="' + id + '" class="textContainer"> </div></li>');
    $('#' + id).append('<h2 class="title">' + title + '</h2>');
    $('#' + id).append('<p class="description">' + description + '</p>');
    $('#' + id).append('<h3 class="rate">' + rate + '</h3>');

    $('#image' + id).append('<img class="image" src="' + image + '"/>');


    this.id = id + 1;

    console.log(this.id);  

  };




