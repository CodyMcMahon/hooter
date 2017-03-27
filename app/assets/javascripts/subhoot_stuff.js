/*global $*/
/*subhoot stucture
        <% @subhoots.each do |s| %>
            <% next if !s %>
            <div class="panel panel-default post-panel">
                   <% p = User.find_by(id: s.user) %>
                  <p class = 'list-owl' p><img src="<%= p.profile_image%>"  height="20" width="20" ><a href = /<%= p.name %> > <%= p.name %> </a> <%= s.content %></p>
            </div>
        <% end %>
*/
var SUBHOOT_TIMELINE_ASYNC_CHECKER = false;
var update_subhoot_timeline = function(id){
    if(SUBHOOT_TIMELINE_ASYNC_CHECKER){
        return;
    }
    else{
        SUBHOOT_TIMELINE_ASYNC_CHECKER = true;
    }
    var $m = $("#subhoot-timeline-"+id)
    var html_data = "";
    $.getJSON( "/get_subhoots_update/"+id+'/'+$m.attr('last_id'), function( subhoot ) {
        //alert($tl.attr('last_id'));
        for(var i = 0; i < subhoot.length;i++){
            html_data += '<div class="panel panel-default post-panel panel-color'+Math.floor(Math.random()*20+1)+'">';
            html_data += '<p class = "list-owl" p><img class="avatar" src="'+subhoot[i].avatar+'"  height="20" width="20" ><a href = "'+subhoot[i].user_link+'" > '+subhoot[i].username+' </a> '+subhoot[i].content+'</p>';
            html_data += '</div>';
        }
        $m.append(html_data);
        if(subhoot.length > 0){
            $m.attr('last_id',subhoot[subhoot.length-1].subhoot_id);
        }
        SUBHOOT_TIMELINE_ASYNC_CHECKER = false;
    });
    
}
var render_subhoot_timeline = function(id){
    SUBHOOT_TIMELINE_ASYNC_CHECKER = false;
    var $m = $("#subhoot-timeline-"+id)
    var html_data = "";
    $.getJSON( "/get_subhoots/"+id, function( subhoot ) {
        for(var i= 0;i < subhoot.length;i++){
            //<img src=<%=@p.profile_image%>  height="14" width="14" ><a href = /<%= @p.name.gsub(" ","%20") if @p%> > <%= @p.name  if @p%> </a>
            html_data += '<div class="panel panel-default post-panel panel-color'+Math.floor(Math.random()*20+1)+'">';
            html_data += '<p class = "list-owl" p><img class="avatar" src="'+subhoot[i].avatar+'"  height="20" width="20" ><a href = "'+subhoot[i].user_link+'" > '+subhoot[i].username+' </a> '+subhoot[i].content+'</p>';
            html_data += '</div>';
        }
        $m.append(html_data);
        if(subhoot.length > 0){
            $m.attr('last_id',subhoot[subhoot.length-1].subhoot_id);
        }
        else{
            $m.attr('last_id',0);
        }
    });
    $("#subhoot-timeline-"+id).attr('updating','true');
    setTimeout((function runForever2(){
        if ($("#subhoot-timeline-"+id) && $("#subhoot-timeline-"+id).attr('updating') === 'true'){
            //alert(Document.location.toString());
            update_subhoot_timeline(id);
            setTimeout(runForever2, 10000);
        }
    }), 5000);
};

/*

var update_time_line = function(){
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
    });
}
var render_time_line = function(){
    $.getJSON( "/my_timeline", function( hoots ) {
        draw_hoots(hoots);
    });
    $('#timeline').attr('updating-from-home','true');
    setTimeout((function runForever(){
        if ($('#timeline') && $('#timeline').attr('updating-from-home') === 'true'){
            //alert(Document.location.toString());
            update_time_line();
            setTimeout(runForever, 5000);
        }
    })(), 5000);
};
*/



















var enable_subhoot_form = function(id){
    
    
    var $text = $('#subhoot-content-box-'+id);
    var $button = $('#subhoot-button-'+id);
    var send_subhoot = function(){
        //alert("got this far?");
        $.post( "/subhoot",  { 'content': $text.val(),'post_id': ''+id},function(data){
            if (data == "success"){
                $text.val("");
                //update_time_line();
            }
            else{
                alert(data);
            }
            update_subhoot_timeline(id);
        });
    };
    $button.click(send_subhoot);
    $(document).off('keydown').keydown(function(key){
        //alert(key);
        if(parseInt(key.which)===13 && $text.is(":focus")){//
            send_subhoot();
        }
    });
    $text.focus();
};