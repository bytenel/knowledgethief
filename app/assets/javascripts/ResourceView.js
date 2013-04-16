var ResourceView = function(){
	var resource_id = 0;
	var isToggledUp = true;
	var currentPosition = 0;
  	var slideWidth = $(window).width();
  	var slideHeight = $(window).height();
  	var slides = $('.slide');
  	var numberOfSlides = slides.length;
    var searchResultURLS = new Array();
    var iFrameURLS = new Array();
    var slideDisabled = false;
    var slidesContainer = $('#slidesContainer');
    var slideShow = $("#slideshow");
    var slidesInner = $('#slideInner');
    var slideHistory = new Array(); //left 0; right 1;
    var historyStackSize = 0;
    var isPath_link = false;
    var pinsArray = [];
	init = function(url,new_resource_id){
        window.resourceview_active = true;
		resource_id = new_resource_id;
		setKeyBindings();
		updateBrowserHistory();
		cleanUpWindow();
		slidesContainer.css('overflow', 'hidden');
		historyStackSize++;
		// Remove scrollbar in JS
  		
  		slideWidth = $(window).width();
        if(!isPath_link){
            $('.pin').each(function(){
                searchResultURLS.push($(this).find('.resourceTitle').attr('href'));
                pinId = $(this).find('.resourceTitle').attr('value');
                pinTitle = $(this).find('.resourceTitle').text().substring(0,50);
                pinLink = $(this).find('.resourceTitle').attr('href').substring(0,47);
                pinDescription = $(this).find('.resourceDescription').text().substring(0,250);
                pinImage = $(this).find('.thumbImg').attr('src');
                pinsArray.push({'pinId' : pinId, 'pinTitle' : pinTitle, 'pinLink' : pinLink, 'pinDescription' : pinDescription, 'pinImage' : pinImage});
                getPins();
            });
        }
		var isFirst = true;
		for(var i = 0 ; i< searchResultURLS.length; i++){
			if(searchResultURLS[i] === url){
				if(i != 0){//load the page before the current click.
					var prevIframe = createIframe(searchResultURLS[i-1]);
					iFrameURLS.push(searchResultURLS[i-1]);
					isFirst = false;
				}
				//load the current click
				var tempIFrame = createIframe(searchResultURLS[i]);
				iFrameURLS.push(searchResultURLS[i]);
				if(i < searchResultURLS.length-1){
					var nextIFrame = createIframe(searchResultURLS[i+1]);
					iFrameURLS.push(searchResultURLS[i+1]);
				}
				break;
			}
		}
    	/* Initialize the iFrames */
		slides = $('.slide');
		slides
    		.wrapAll('<div id="slideInner"></div>')
    		// Float left to display horizontally, readjust .slides width
			.css({
      		'float' : 'left',
      		'height': slideHeight,
      		'width' : slideWidth
    	});
		slidesInner = $('#slideInner');
		numberOfSlides = slides.length
		// Set #slideInner width equal to total width of all slides
  		$('#slideInner').css('width', slideWidth * numberOfSlides);
  		if(!isFirst){
  			$('#slideInner').css('marginLeft', -slideWidth);
  			currentPosition++;
  		}
		$("#slideshow").fadeIn("fast");
		$("#slidesContainer").fadeIn("fast");
		$('#contentWrapper').fadeOut();
		$('#header').fadeOut();
		$("#bar-wrap").animate(
		   {"right": "10px"},{
		     duration: 1000,
		     complete: function(){
		     	cleanUpWindow();
		       	setTimeout(function() {
		    		if(!isToggledUp){
					 $('#navCollapse').stop().fadeOut();
					 }
					}, 3000 );
		     }
		   });
	},
    getPins = function(){
      $('.searchList').empty();
      if(!isPath_link){
        for(var i = 0; i < pinsArray.length; i++){
          $('.searchList')
            .append("<li><div class='resourceImage'>"
                    +"<img src='" +pinsArray[i]['pinImage'] +"' width='100%'></div>"
                    +"<div class='resourcesright'><div class='resourceTitle' value='"+pinsArray[i]['pinId'] +"'><h3>" +pinsArray[i]['pinTitle']+"</h3></div>"
                    +"<div class='resourceLink'>("+pinsArray[i]['pinLink'] +")</div>"
                    +"<div class='resourceDescription'>"+ pinsArray[i]['pinDescription']+"</div></div></li>").hide().fadeIn();
        }
      }
    },
	cleanUpWindow = function(){
		slideWidth = $(window).width();
		slideHeight = $(window).height();
		slideShow.css({'width': slideWidth});
		slidesContainer.css({'width': slideWidth});
		slidesContainer.css({'height': slideHeight});
		$('#slideInner').css('width', slideWidth * numberOfSlides);
  		$('.slide').css({
      		'width' : slideWidth,
      		'height': slideHeight
    	});
		slideShow.css({'height': slideHeight});
	},
	createIframe = function(url){
        url = url.replace('http://www.youtube.com/watch?v=','http://www.youtube.com/embed/');
		var newIframe = document.createElement("iframe");
		newIframe.setAttribute("id", "main-iframe2");
		newIframe.setAttribute("src", url);
		newIframe.style.float = "left";
		newIframe.style.height = "100%";
		newIframe.style.width = "100%";
		newIframe.style.border = "none";
		newIframe.style.top = "-1000px";
		newSlide = $("<div class='slide'></div>").appendTo("#slidesContainer");
		$(newSlide).append(newIframe);
	},
	$.fn.changeColors = function(userOptions){
		var randomColor = 'rgb(' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ')';
		// starting color, ending color, duration in ms
    	var options = $.extend({
        	start: "#FF0000",
        	end: randomColor,
       	 	time: 2000
    	}, userOptions || {});
    	$(this).animate({
        backgroundColor: options.end
    	}, options.time);
    	return this;
	},

	updateBrowserHistory = function(){
		window.history.isPageLoader = true; // set a variable in our history we can check for during a popstate event. 
		window.history.isResource = true; // set a variable in our history we can check for during a popstate event.
		window.history.pushState({isResource: true, isPageLoader : false}, "resourceViewEvent", '/resources/'+resource_id);
		historyStackSize++;
	},
	slideView = function(distance){ // -1 to slide left, +1 to slide right.
		currentPosition = currentPosition + distance;
		slideHistory.push(distance);
		// Move slideInner using margin-left
  		$("#slideInner").animate(
   			{"marginLeft": slideWidth*(-currentPosition)},{
     		duration: 750,
     		complete: function(){
       			manageIframes(currentPosition);
       			updateBrowserHistory(); // update our browser history to reflect the new page.
       			slideDisabled = false;
		     }
		});
	},
	setKeyBindings = function(){
	    $('#info-button').mouseover(function(){
	          $('#navCollapse').fadeIn();
	       });
	    $('#bar-wrap').mouseleave(function(){
	    	setTimeout(function() {
	    		if(!isToggledUp){
					 $('#navCollapse').stop().fadeOut();
						 }
						}, 8000 );
	       });
		$('#home').unbind().click(function(event){
				event.preventDefault();
  			history.go(-(slideHistory.length+1));
  			logUserEndTime(resource_id);
  			currentPosition = 0;
			numberOfSlides = 0;
			slideHistory = [];
	    	historyStackSize = 0;
  		});
  		$('.control')
    		.bind('click', function(event){
    		event.preventDefault();
    		// Determine new position
    		if(!slideDisabled){
    			slideDisabled = true;
    			var isNext  = ($(this).attr('id')=='nextslide') ? true : false;
	    		if(currentPosition == 0  && !isNext)
	    			return false;
	    		else if(currentPosition == numberOfSlides-1 && isNext)
	    			return false;
	    		else
    			($(this).attr('id')=='nextslide') ? slideView(1) : slideView(-1);
    		}
    	});
    	$('.navigation-box').click(function(event){
    		event.preventDefault();
    		var clickedButtonId = event.target.id;
	    	$('.navHere').slideUp(250, function() {
	    		var oldActive = $('.navHere').attr('id');
	    		switch (clickedButtonId) {
	        		case 'resourceNav-info':
	        			$('#information-box').slideDown(250);
	        			$("#"+oldActive).removeClass('navHere');
						$('#information-box').addClass('navHere');
	             		break;
	             	case 'resourceNav-addQuestion':
	             		$('#questions-form').slideDown(250);
	             		$("#"+oldActive).removeClass('navHere');
						$('#questions-form').addClass('navHere');
	             		break;
	             	case 'resourceNav-addResource':
	             		$('#resource-form').slideDown(250);
	             		$("#"+oldActive).removeClass('navHere');
						$('#resource-form').addClass('navHere');
	             		break;
	             	case 'resourceNav-addPath':
	             		$('#path-form').slideDown(250);
	             		$("#"+oldActive).removeClass('navHere');
						$('#path-form').addClass('navHere');
	             		break;
	             	case 'resourceNav-addFlag':
	             		$('#flag-form').slideDown(250);
	             		$("#"+oldActive).removeClass('navHere');
						$('#flag-form').addClass('navHere');
	             		break;
	    		}
			});
    	});
		$(".ajaxUpvote").click(function(e){
			e.preventDefault();
			vote('up');
		});
		$(".ajaxDownvote").click(function(){
			vote('down');
		});
		$('#saveComment').click(function(){
			console.log("WOWOOWOW");
			var commentText = $("#commenttext").val();
			saveComment(commentText);
		});

		$('#newFlag').click(function(){
			var flagText = $("#flagText").val();
			newFlag(flagText);
		});

		$('#upvote').mouseover(function(){
	          $(this).prev().slideDown(250);
	          $(this).animate({opacity: 1}, 250);
	       });

	    $('#upvote').mouseout(function(){
	          $(this).prev().slideUp(250);
	          $(this).animate({opacity: 0}, 250);
	       });
	    $('#downvote').mouseover(function(){
	          $(this).prev().slideDown(250);
	          $(this).animate({opacity: 1}, 250);
	       });

	    $('#downvote').mouseout(function(){
	          $(this).prev().slideUp(250);
	          $(this).animate({opacity: 0}, 250);
	       });

	    $('#button-home').mouseover(function(){
	          $(this).find('a').prev().slideDown(250);
	          $(this).find('a').animate({opacity: 1}, 250);
	       });

	    $('#button-home').mouseout(function(){
	          $(this).find('a').prev().slideUp(250);
	          $(this).find('a').animate({opacity: 0}, 250);
	       });
	    $("#info-toggle").unbind("click").click(function(e){
		e.preventDefault();
	    	if( e.target.tagName.toUpperCase() !== 'INPUT' ) {
	    		toggleBar();
	    	}
		});
		$(window).bind('popstate', function (ev){
  			if (window.history.isResource && ev.originalEvent.state == null){
  				// If a popstate occurs, check to see if we're in a resource, if so, remove the iframe, else, do nothing.
  				// if the originalEvent.state is false, then we know we're returning to the original page.
  				removeBar();
  			}else {
  				if(ev.originalEvent.state.isResource){
  				switch(slideHistory.pop()){
  					case -1:
  						currentPosition++;
  						break;
					case 1:
						currentPosition--;
						break
  				}
  				$("#slideInner").stop().animate(
					{"marginLeft": slideWidth*(-currentPosition)},{
	 				duration: 750,
	 				complete: function(){
			   			manageIframes(currentPosition);
		     		}
				});
  			}
  		}
		});
	},
	manageIframes = function(position){
		//check the current position and load the next iframe if possible.
		var currentLink = iFrameURLS[position];
		var new_res_id = $('a[href$="'+currentLink+'"]').attr('value');

		logUserEndTime(resource_id);
		resource_id = new_res_id;
		logUser(resource_id);

		comments(resource_id);
    	if(position==0){
    		$('#leftControl').hide()
    	}else if(position == numberOfSlides-1){
    		var indexOfUrl = searchResultURLS.indexOf(iFrameURLS[position]);
    		var tempIFrame = document.createElement("iframe");
				tempIFrame.setAttribute("id", "main-iframe2");
				tempIFrame.setAttribute("src", searchResultURLS[indexOfUrl+1]);
				tempIFrame.style.float = "left";
				tempIFrame.style.height = "100%";
				tempIFrame.style.width = "100%";
				tempIFrame.style.border = "none";
				tempIFrame.style.top = "-1000px";
				newSlide = $("<div class='slide'></div>").appendTo("#slideInner");
				$(newSlide).append(tempIFrame);
				iFrameURLS.push(searchResultURLS[indexOfUrl+1]);
    	}
    	/* Initialize the iFrames */
		slides = $('.slide');
		slides.css({
      		'float' : 'left',
      		'height': slideHeight,
      		'width' : slideWidth
    	});
		numberOfSlides = slides.length
		// Set #slideInner width equal to total width of all slides
  		$('#slideInner').css('width', slideWidth * numberOfSlides);
	},
	toggleBar = function(){
		if(isToggledUp){
			$("#info-button").removeClass("toggled-a");
			$("#info-toggle").removeClass("toggled-bg")
			$("#bar-wrap").animate(
		  	 	{"bottom": "-340px"},{
		     		duration: 500,
		     		complete: function(){

		     	}
		   });
			isToggledUp = false;
		}else{
			$("#info-button").addClass("toggled-a");
			$("#info-toggle").addClass("toggled-bg");
			$("#bar-wrap").animate(
				{"bottom": "10px"},{
		     	duration: 500,
		     	complete: function(){
		     }
		   });
			$('#navCollapse').stop().fadeIn();
			isToggledUp = true;
		}
	},
	removeBar = function(){
		logUserEndTime(resource_id);
		$("#slidesContainer").html('');
		$("#slideshow").fadeOut("fast");
		$("#slidesContainer").fadeOut("fast");
		$('#contentWrapper').fadeIn();
		$('#header').fadeIn();
		resource_id = 0;
		if(isToggledUp == true){
			toggleBar();
		}
		$("#bar-wrap").animate(
		   {"right": "-5000px"},{
		     duration: 1000,
		     complete: function(){
		       	$("#fadeAway").fadeIn(1000);
		     }
		   });
		currentPosition = 0;
		numberOfSlides = 0;
		slideHistory = [];
    	historyStackSize = 0;
        window.resourceview_active = false;
        setTimeout(function(){
                $('#columns').masonry( 'reloadItems' );
            }
            ,200);

	},

	comments = function(new_resource_id){
        url = "/rcomments/forresource/"+new_resource_id;
		return $.getScript(url).done(function(){
        });
	},
	logUser = function(new_resource_id){
		$.ajax({
			type: "post",
			url: "/userResourceView",
			data: {
				resource_id : new_resource_id
			},
			dataType: "json",
			// Define request handlers.
			success: function( objResponse ){
				// Check to see if request was successful.
				if (objResponse.success){
				} else {
				}
			},
			error: function( objRequest, strError ){

			}
		});
	},
	logUserEndTime = function(new_resource_id){
		$.ajax({
			type: "PUT",  /*the request type being sent. (GET for index, POST for create, PUT for update)*/
			url: "/userResourceView/" + resource_id,
			data: {
				//resource_id : new_resource_id   /*parameters being sent to the controller.*/
			},
			dataType: "json",
			// Define request handlers.
			success: function( objResponse ){  /* objResponse is the return data from the server on success, status 200 == success*/
				// Check to see if request was successful.
				if (objResponse.success){  /* if you look at the controller, i return :json= {:success=>true}*/
				} else {
				}
			},
			error: function( objRequest, strError ){ /* if something fucks up the server returns something other than 200, this method gets called. (404, 500) */

			}
		});
	};
	saveComment = function(commentText){
		console.log(commentText);
		$.ajax({
			type: "post",
			url: "/rcomments",
			data: {
				content : commentText,
				resource : resource_id

			},
			dataType: "json",
			// Define request handlers.
			success: function( objResponse ){
				// Check to see if request was successful.
				console.log("works");
				$('.commentsList').html('');
				$.each(objResponse.comments, function(i, item) {
    				$('.commentsList').append("<li>" +item.content +"</li>").hide().fadeIn();
				});
			},
			error: function( objRequest, strError ){
				alert("error with comment");
			}
		});
	};
	newFlag = function(flagText){
		$.ajax({
			type: "post",
			url: "/flags/",
			data: {
				content : flagText,
				resource : resource_id
			},
			dataType: "json",
			// Define request handlers.
			success: function( objResponse ){
				$('#newFlagForm').html("");
				$('#newFlagForm').append("Success.");
				console.log("Success");
			},
			error: function( objRequest, strError ){
				alert("error with comment");
			}
		});
	},
    setPaths = function(pathURLS, url_paths){
        searchResultURLS = url_paths;
        pinsArray = pathURLS;
        getPins();
        isPath_link = true;
    },
	vote = function(vote){
		$.ajax({
			type: "post",
			url: "/resources/"+resource_id +"/vote",
			data: {
				type : vote
			},
			dataType: "json",
			// Define request handlers.
			success: function( objResponse ){
				// Check to see if request was successful.
				if (objResponse.success){
					alert("Thanks for voting!");
					if(vote === 'up'){
						$('.upvote_image').attr('src',"/assets/circle_thumbsUp_here.png");
					}else{
						$('.downvote_image').attr('src',"/assets/circle_thumbsDown_here.png");
					}
				} else {
					alert("sucess1");
				}
			},
			error: function( objRequest, strError ){
				alert("Please login or create an account to vote");
			}
		});
	};
	return{
		init : init,
		removeBar : removeBar,
		comments : comments,
		vote : vote,
		logUser : logUser,
		logUserEndTime : logUserEndTime,
		saveComment : saveComment,
		toggleBar : toggleBar,
		setKeyBindings : setKeyBindings,
        setPaths  : setPaths
	};
};

$(function(){
	var rView = new ResourceView();
    $columns = $('#columns');
    $columns.on('click', '.resourceTitle', function (){
		var link = $(this).attr('href');
		//this is hacky as shit. split on /'s and check if its a resource link
		var parts = link.split('/');
		if(parts[1] == "resources"){
			return true;
		}else{
			var link_href = link;
			var get_resource_id = $(this).attr('value');
	    	rView.init(link_href, get_resource_id);
	    	rView.setKeyBindings();
			rView.comments(get_resource_id);
			rView.logUser(get_resource_id);
			return false;
		}
		return false;
	});
    $columns.on('click', '.thumbImg', function (){
        var link = $(this).parent().attr('href');
        //this is hacky as shit. split on /'s and check if its a resource link
        var parts = link.split('/');
        if(parts[1] == "resources"){
            return true;
        }else{
            var link_href = link;
            var get_resource_id = $(this).parent().attr('value');
            rView.init(link_href, get_resource_id);
            rView.setKeyBindings();
            rView.comments(get_resource_id);
            rView.logUser(get_resource_id);
            return false;
        }
        return false;
    });
    $('.pathPin').on('click', '.playPath', function(){
        $(this).parents('.pathButtons').siblings('.pathResultsDetails').find('.pathLinkItems').each(function(){
            res_array = [];
            url_array = [];
            $current_resource = $(this).find('a');
            url_array.push($current_resource.attr('href'));

            pinId = $current_resource.attr('value');
            pinTitle = $current_resource.find('.resourceTitle').text().substring(0,50);
            pinLink = $current_resource.attr('href').substring(0,47);
            pinDescription =  $current_resource.find('.pathPinDescription').text().substring(0,250);
            pinImage =  $current_resource.find('.thumbImg').attr('src');
            res_array.push({'pinId' : pinId, 'pinTitle' : pinTitle, 'pinLink' : pinLink, 'pinDescription' : pinDescription, 'pinImage' : pinImage});
        });
        var path_link = res_array[0]['pinLink'];
        var get_resource_id = res_array[0]['pinId'];
        var path_parts = path_link.split('/');
        rView.setPaths(res_array, url_array);
        rView.init(path_link, get_resource_id);
        rView.setKeyBindings();
        rView.comments(get_resource_id);
        rView.logUser(get_resource_id);
        return false;
    });

});