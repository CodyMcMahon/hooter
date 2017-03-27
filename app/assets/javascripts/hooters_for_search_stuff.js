/*global $*/
var render_hooters_through_regex = function(regex_string){
    var $m = $("#hooters-holding-object")
    var html_data = "";
    $.getJSON( "/hooters_through_regex/"+regex_string, function( peeps ) {
        for(var i= 0;i < peeps.length;i++){
            //<img src=<%=@p.profile_image%>  height="14" width="14" ><a href = /<%= @p.name.gsub(" ","%20") if @p%> > <%= @p.name  if @p%> </a>
            html_data += '<div><p class = "list-owl" p><img class="avatar" src="'+peeps[i].avatar+'"  height="20" width="20" ><a href = "'+peeps[i].link+'" > '+peeps[i].username+' </a></p></div>';
        }
        $m.append(html_data);
    });
};