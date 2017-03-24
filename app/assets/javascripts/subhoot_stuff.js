/*subhoot stucture
        <% @subhoots.each do |s| %>
            <% next if !s %>
            <div class="panel panel-default post-panel">
                   <% p = User.find_by(id: s.user) %>
                  <p class = 'list-owl' p><img src="<%= p.profile_image%>"  height="20" width="20" ><a href = /<%= p.name %> > <%= p.name %> </a> <%= s.content %></p>
            </div>
        <% end %>
*/
var render_subhoot_timeline = function(id){
    var $m = $("#subhoot-timeline-"+id)
    var html_data = "";
    $.getJSON( "/get_subhoots/"+id, function( subhoot ) {
        for(var i= 0;i < subhoot.length;i++){
            //<img src=<%=@p.profile_image%>  height="14" width="14" ><a href = /<%= @p.name.gsub(" ","%20") if @p%> > <%= @p.name  if @p%> </a>
            html_data += '<div class="panel panel-default post-panel panel-color'+((i+12)%10+9)+'">';
            html_data += '<p class = "list-owl" p><img src="'+subhoot[i].avatar+'"  height="20" width="20" ><a href = "'+subhoot[i].user_link+'" > '+subhoot[i].username+' </a> '+subhoot[i].content+'</p>';
            html_data += '</div>';
        }
        $m.append(html_data);
    });
};