var enable_hoot_form = function(){
    
    
    $text = $('#hoot-content-box');
    $button = $('#hoot-button');
    var send_hoot = function(){
        $.post( "/hoot",  { 'content': $text.val()},function(data){
            if (data == "success"){
                $text.val("");
                //alert('test');
                update_time_line();
            }
            else{
                alert(data);
            }
        });
    };
    $button.click(send_hoot);
    $(document).off('keydown').keydown(function(key){
        //alert(key);
        if(parseInt(key.which)===13 && $text.is(":focus")){//
            send_hoot();
        }
    });
    $text.focus();
};