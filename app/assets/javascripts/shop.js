$(document).ready(function() {
  $('body').fadeIn(400);

  $('#myCarousel').carousel()
  $('#newProductCar').carousel()

/* Home page item price animation */
  $('.thumbnail').mouseenter(function() {
    $(this).children('.zoomTool').fadeIn();
  });

  $('.thumbnail').mouseleave(function() {
  	$(this).children('.zoomTool').fadeOut();
  });

// Show/Hide Sticky 'Go to top' button
	$(window).scroll(function(){
		if($(this).scrollTop()>200){
			$('.gotop').fadeIn(200);
		}
		else{
			$('.gotop').fadeOut(200);
		}
	});

});
