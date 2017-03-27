/*global $*/
var render_followers = function(name){
    var $m = $('#followers-box');
    var html_data = "";
    $.getJSON( "/followers_for/"+name, function( peeps ) {
        for(var i= 0;i < peeps.length;i++){
            //<img src=<%=@p.profile_image%>  height="14" width="14" ><a href = /<%= @p.name.gsub(" ","%20") if @p%> > <%= @p.name  if @p%> </a>
            html_data += '<div><p class = "list-owl" p><img class="avatar" src="'+peeps[i].avatar+'"  height="20" width="20" ><a href = "'+peeps[i].link+'" > '+peeps[i].username+' </a></p></div>';
        }
        $m.append(html_data);
    });
};
var render_following = function(name){
    var $m = $('#following-box');
    var html_data = "";
    $.getJSON( "/followings_for/"+name, function( peeps ) {
        for(var i= 0;i < peeps.length;i++){
            //<img src=<%=@p.profile_image%>  height="14" width="14" ><a href = /<%= @p.name.gsub(" ","%20") if @p%> > <%= @p.name  if @p%> </a>
            html_data += '<div><p class = "list-owl" p><img class="avatar" src="'+peeps[i].avatar+'"  height="20" width="20" ><a href = "'+peeps[i].link+'" > '+peeps[i].username+' </a></p></div>';
        }
        $m.append(html_data);
    });
};