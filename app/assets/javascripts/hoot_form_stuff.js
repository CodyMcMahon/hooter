var enable_hoot_form = function(){
    
    
    $text = $('#hoot-content-box');
    $button = $('#hoot-button');
    var send_hoot = function(){
        $.post( "/hoot",  { 'content': $text.val()},function(data){
            if (data == "success"){
                $text.val("");
                update_time_line();
            }
            else{
                alert(data);
            }
        });
    };
    $button.click(send_hoot);
    $(document).unbind().keydown(function(key){
        //alert(key);
        if(parseInt(key.which)===13 && $text.is(":focus")){//
            send_hoot();
        }
    });
    $text.focus();
};