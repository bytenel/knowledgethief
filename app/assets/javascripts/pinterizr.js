var Pinterizr = function () {
    var $container = $('#columns');
	init = function(){
        /* init the masonry columns */
        $container.imagesLoaded(function(){
            //$('.pin').css({opacity: 1});
            $container.masonry({
                itemSelector : '.pin',
                isResizable : true,
                isAnimated: true,
                animationOptions: {
                    duration: 400,
                    easing: 'swing',
                    queue: false
                }
            });
        });
		setKeyBindings();
	},
	setKeyBindings = function(){
        var $pins = $('.pin'),timeout;
        $container.on( 'mouseenter', '.pin', function( event ) {
            var $pin = $(this);
            clearTimeout( timeout );
            timeout = setTimeout( function() {
                if( $pin.hasClass('active') ) return false;
                $('.pin').not($pin).removeClass('active').addClass('blur');
                $pin.removeClass('blur').addClass('active');
                $('.pin').not($pin).find(".resourceButtons").stop().animate({
                    opacity: 0
                }, 250);
            }, 75 );
            $pin.find(".resourceButtons").stop().animate({
                opacity: 1
            }, 250);

        });
        $container.on( 'mouseleave', function( event ) {
            clearTimeout( timeout );
            $('.pin').removeClass('active blur');
        });
	}
	return{
		init : init,
		setKeyBindings : setKeyBindings
	};
};
$(function(){
	var pinterest = new Pinterizr();
	pinterest.init();
    pinterest.setKeyBindings();
    $('.path_bttn').click(function () {
        $(this).next().toggle();
    });
	$( document ).bind('resourcesUpdated', function(){
        setTimeout(function(){
                $('.pin').removeClass('active').removeClass('blur');
                $('.path_bttn').click(function () {
                    $(this).next().toggle();
                });
            }
            ,200);
	});
});
