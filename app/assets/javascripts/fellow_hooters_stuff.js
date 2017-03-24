var render_fellow_hooters = function(){
    var $m = $('#fellow-hooters-title');
    var html_data = "";
    $.getJSON( "/fellow_hooters", function( hoots ) {
        for(var i= 0;i < hoots.length;i++){
            //<img src=<%=@p.profile_image%>  height="14" width="14" ><a href = /<%= @p.name.gsub(" ","%20") if @p%> > <%= @p.name  if @p%> </a>
            html_data += '<div><img src='+hoots[i].avatar+'  height="14" width="14" ><a href = '+hoots[i].link+'> '+hoots[i].username+' </a></div>';
        }
        $m.after(html_data);
    });
};