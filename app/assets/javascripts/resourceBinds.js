rView = new ResourceView();
$columns = $('.resourceShowHolder');
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