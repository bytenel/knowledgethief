$(window).scroll ->
    return if(window.pagination_loading)

    url = $('.pagination .next_page').attr('href')
    if url &&  $(window).scrollTop() > $(document).height() - $(window).height() - 50
        window.pagination_loading = true
        $('.pagination').text('Fetching more resources...')
        $.getScript(url).done -> 
        	window.pagination_loading = false
        	