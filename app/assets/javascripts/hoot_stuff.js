var TIMELINE_ASYNC_CHECKER = false;
var make_buttons_work = function(){
    $('.fun-buttons').unbind().click(function(){
        var $t = $(this);
        $.post( "/"+$(this).attr('route'),  { to_id: $(this).attr('to_id'), post_id: $(this).attr('post_id')},function(data){
            if (data == "success"){
                $num = $('#'+$t.attr('id')+'-count');
                $num.text((Number($num.text())+1).toString());
            }
            else{
                alert("something went wrong!!!!");
            }
        });
        var dec = Math.floor(Math.random()*4);
        if (dec === 1){
            $(this).animate({ top:'+=6px'}, 150);
            $(this).animate({ top:'-=6px'}, 150 );
        }
        else if (dec === 2){
            $(this).animate({ top:'-=6px'}, 150 );
            $(this).animate({ top:'+=6px'}, 150 );
        }
        else if (dec === 3){
            $(this).animate({ left:'-=6px'}, 150 );
            $(this).animate({ left:'+=6px'}, 150 );
        }
        else {
            $(this).animate({ left:'+=6px'}, 150 );
            $(this).animate({ left:'-=6px'}, 150 );
        }
    });
};
/*
hoot format
<div class="panel panel-default post-panel">
    <div class="panel-body">
        <div class="panel-body">
            <div class = "col-xs-2">  <h3> 
                <img class= 'avatar hoot-avatar' src="<%=User.find(@p.user_id).profile_image%>" height="70" width="70" />
            </div>
            
            <div class = "col-xs-10">  
                <div class = "hoot-name-time-divider">
                    <a href='/<%= User.find(@p.user_id).name %>' class = "post-username"> <%= User.find(@p.user_id).name %> </a><a href = '/single_hoot/<%= @p.id %>'><span class = 'post-time'><%= @p.created_at.to_formatted_s(:short) %></span></a>
                </div>
            
                <div class = "hoot-content-divider">
                    <p class = "post-words wb"> <%= @p.content %> </p>
                </div>
            </div>
        </div>
        <p class = "post-buttons"> 
            <a href = '/single_hoot/<%=@p.id%>'><span class = "glyphicon glyphicon-pencil post-link" aria-hidden="true">reply(<%= @p.subhoots.count %>)</span></a>
            
            
            <span class = "glyphicon glyphicon-star post-link fun-buttons"  id='<%=@p.id%>-like' to_id='<%=@p.user_id%>' post_id='<%=@p.id%>' route='like' aria-hidden="true"></span>
            <span id='<%=@p.id%>-like-count'><%= @p.likes.count %></span>
            
           
            <span class = "glyphicon glyphicon-trash post-link fun-buttons"  id='<%=@p.id%>-hate' to_id='<%=@p.user_id%>' post_id='<%=@p.id%>' route='hate' aria-hidden="true"></span>
            <span id='<%=@p.id%>-hate-count'><%= @p.hates.count %></span>
        </p>
    </div>
</div>
*/
//2017-03-24T17:48:14.904Z
//new Date(year, month, day, hours, minutes, seconds, milliseconds)
var s_i = function(s,l,r){
    var x = Number(s.substring(l,r));
    //console.log(x);
    return x;
}

var parse_awful_time_format = function(t){
    //console.log(t);
    var curr_day = new Date(Date.UTC(s_i(t,0,4), s_i(t,5,7)-1, s_i(t,8,10), s_i(t,11,13), s_i(t,14,16), s_i(t,17,19), s_i(t,20,23)));
    //console.log(curr_day.getTime());
    //console.log((new Date()).getTime());
    var time_diff = (new Date((new Date()).getTime()-curr_day.getTime())).getTime();
    if(time_diff < 5000){
        return "right now"
    }
    else if(time_diff < 60000){
        return "less than a minute ago";
    }
    else if(time_diff < 120000){
        return "about a minute ago";
    }
    else if(time_diff < 300000){
        return "couple minute ago";
    }
    else if(time_diff < 3600000){
        return "several minutes ago";
    }
    else if(time_diff < 24*3600000){
        return "like an hour or something ago";
    }
    else if(time_diff < 10*24*3600000){
        return "over a day ago I stopped counting";
    }
    else{
        return "yeah this is real old tbh";
    }
}


var htmlify_hoot = function(hoot,i){
    var html_data = '<div class="panel panel-default post-panel panel-color'+(Math.floor(Math.random()*20)+1)+'">';
    html_data += '<div class="panel-body">';
    html_data += '<div class="panel-body">';
    html_data += '<div class = "col-xs-2">  <h3> ';
    html_data += '<img class= "avatar hoot-avatar" src="'+ hoot.avatar +'" height="70" width="70" />';
    html_data += '</div>';
    html_data += '<div class = "col-xs-10">  ';
    html_data += '<div class = "hoot-name-time-divider">';
    html_data += '<a href="/'+ hoot.username +'" class = "post-username"> '+hoot.username+' </a><a href = "/single_hoot/'+hoot.post_id+'"><span class = "post-time">'+ parse_awful_time_format(hoot.time) +'</span></a>';
    html_data += '</div>';
    html_data += '<div class = "hoot-content-divider">';
    html_data += '<p class = "post-words wb"> '+hoot.content+' </p>';
    html_data += '</div>';
    html_data += '</div>';
    html_data += '</div>';
    html_data += '<p class = "post-buttons"> ';
    html_data += '<a href = "/single_hoot/'+hoot.post_id+'"><span class = "glyphicon glyphicon-pencil post-link" aria-hidden="true">reply('+hoot.subhoot_count+')</span></a>';
    html_data += '<span class = "glyphicon glyphicon-star post-link fun-buttons like-button"  id="'+hoot.post_id+'-like" to_id='+hoot.user_id+' post_id='+hoot.post_id+' route="like" aria-hidden="true"></span>';
    html_data += '<span id="'+hoot.post_id+'-like-count">'+hoot.like_count+'</span>';
    html_data += '<span class = "glyphicon glyphicon-trash post-link fun-buttons hate-button"  id="'+hoot.post_id+'-hate" to_id='+hoot.user_id+' post_id='+hoot.post_id+' route="hate" aria-hidden="true"></span>';
    html_data += '<span id="'+hoot.post_id+'-hate-count">'+hoot.hate_count+'</span>';
    html_data += '</p>';
    html_data += '</div>';
    html_data += '</div>';
    return html_data;
}

var draw_hoots = function(hoots){
    var $tl = $('#timeline');
    var html_data = "";
    for(var i = 0; i < hoots.length;i++){
        html_data += htmlify_hoot(hoots[i],i);
        //alert(html_data);
    }
    $tl.html('<div id = timeline>'+html_data+'</div>');
    if(hoots.length > 0){
        $tl.attr('last_id',hoots[0].post_id.toString());
    }
    else{
        $tl.attr('last_id',''+0);
    }
    /*
    '<div id = timeline>'+html_data+'</div>'
    
    */
    //console.log(html_data);
    make_buttons_work();
};
var update_time_line = function(){
    if(TIMELINE_ASYNC_CHECKER){
        return;
    }
    else{
        TIMELINE_ASYNC_CHECKER = true;
    }
    var $tl = $('#timeline');
    var html_data = "";
    $.getJSON( "/my_timeline_update/"+$tl.attr('last_id'), function( hoots ) {
        //alert($tl.attr('last_id'));
        for(var i = 0; i < hoots.length;i++){
            html_data += htmlify_hoot(hoots[i],i);
        }
        $tl.prepend('<div id = timeline>'+html_data+'</div>');
        if(hoots.length > 0){
            $tl.attr('last_id',hoots[0].post_id);
        }
        make_buttons_work();
        TIMELINE_ASYNC_CHECKER = false;
    });
}
var render_time_line = function(){
    TIMELINE_ASYNC_CHECKER = false;
    $.getJSON( "/my_timeline", function( hoots ) {
        draw_hoots(hoots);
    });
    $('#timeline').attr('updating-from-home','true');
    setTimeout((function runForever(){
        if ($('#timeline') && $('#timeline').attr('updating-from-home') === 'true'){
            //alert(Document.location.toString());
            update_time_line();
            setTimeout(runForever, 10000);
        }
    }), 5000);
};
var update_explore = function(){
    var $tl = $('#timeline');
    var html_data = "";
    $.getJSON( "/all_hoots_update/"+$tl.attr('last_id'), function( hoots ) {
        //alert($tl.attr('last_id'));
        for(var i = 0; i < hoots.length;i++){
            html_data += htmlify_hoot(hoots[i],i);
        }
        $tl.prepend('<div id = timeline>'+html_data+'</div>');
        if(hoots.length > 0){
            $tl.attr('last_id',hoots[0].post_id);
        }
        make_buttons_work();
    });
}
var render_explore = function(){
    $.getJSON( "/all_hoots", function( hoots ) {
        draw_hoots(hoots);
    });
    $('#timeline').attr('updating-from-explore','true');
    setTimeout((function runForever(){
        if ($('#timeline') && $('#timeline').attr('updating-from-explore') === 'true'){
            //alert(Document.location.toString());
            update_explore();
            setTimeout(runForever, 5000);
        }
    })(), 5000);
};
var update_hoot_hoots = function(){
    var $tl = $('#timeline');
    var html_data = "";
    $.getJSON( "/hoot_hoots_update/"+$tl.attr('last_id'), function( hoots ) {
        //alert($tl.attr('last_id'));
        for(var i = 0; i < hoots.length;i++){
            html_data += htmlify_hoot(hoots[i],i);
        }
        $tl.prepend('<div id = timeline>'+html_data+'</div>');
        if(hoots.length > 0){
            $tl.attr('last_id',hoots[0].post_id);
        }
        make_buttons_work();
    });
}
var render_hoot_hoots = function(){
    $.getJSON( "/hoot_hoots", function( hoots ) {
        draw_hoots(hoots);
    });
    $('#timeline').attr('updating-from-hoot-hoots','true');
    setTimeout((function runForever(){
        if ($('#timeline') && $('#timeline').attr('updating-from-hoot-hoots') === 'true'){
            //alert(Document.location.toString());
            update_hoot_hoots();
            setTimeout(runForever, 5000);
        }
    })(), 5000);
};
var render_hoots_for = function(name){
    $.getJSON( "/hoots_for/"+name, function( hoots ) {
        draw_hoots(hoots);
    });
};
var render_hoots_through_regex = function(regex_string){
    $.getJSON( "/hoots_through_regex/"+regex_string, function( hoots ) {
        draw_hoots(hoots);
    });
};
var render_single_hoot = function(id){
    $.getJSON( "/single_json/"+id, function( hoots ) {
        draw_hoots(hoots);
    });
};