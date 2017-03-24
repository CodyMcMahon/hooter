//<p class="random-post" > <%= @m.content  if @m%> </p>
var render_memes = function(){
    var $m = $('#list-of-memes');
    var html_data = "";
    $.getJSON( "/memes", function( hoots ) {
        for(var i= 0;i < hoots.length;i++){
            html_data += '<p class="random-post" > '+ hoots[i].meme +' </p>';
        }
        $m.append(html_data);
    });
};