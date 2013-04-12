$(function(){

	/* init the masonry columns 
	var $container = $('#pathsColumns');
	var containerWidth = $container.width();
	$container.masonry({
		itemSelector : '.pathsPin',
		isResizable : true,
		isAnimated: true,
		animationOptions: {
	    	duration: 400,
		    easing: 'swing',
		    queue: false
		}
	});*/
	var pathDetailBinds = function(){
 		var $pins = $('.pathPin'),timeout;
 		$('#pathsColumns').on( 'click', '.pathDetails', function( event ) {   
		    var $pin = $(this).parents('.pathPin');
		    clearTimeout( timeout );
		    timeout = setTimeout( function() {  
		        if( $pin.hasClass('active') ){
		        	 $pin.removeClass('active');
		        	 $pin.find(".detailsExpand").text("Show Details");
                     $pin.find('.pathResultsDetails').fadeOut();
                     $pin.find('.pathPlayButton').fadeOut();
		        	 return false;
		        }
		        $('.pathPin').not($pin).removeClass('active').find('.pathResultsDetails').fadeOut();
                $('.pathPin').not($pin).find('.pathPlayButton').fadeOut();
		        $pin.addClass('active');
		        $pin.find('.detailsExpand').text("Hide Details");
                $pin.find('.pathResultsDetails').fadeIn();
                $pin.find('.pathPlayButton').fadeIn();
		    }, 75 );
		});
 	};
 	pathDetailBinds();
});

