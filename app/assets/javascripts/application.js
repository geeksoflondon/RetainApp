// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require_tree .

/*SelfService JS*/
$(document).ready(function() {
    if($('#onsite_search').length > 0){
        $('#onsite_search').focus();
    } else if($('.search_box').length > 0) {
        $('.search_box').focus()
    }
    
    ///Is this a badge editing screen
    if (($(".badge").length > 0) && ($(".your_details").length > 0)){
        
        $('#attendee_first_name').focus();
        
        $('#attendee_first_name').bind("keyup keydown change focus focusout", (function() {
            $(".first_name").text($('#attendee_first_name').val())
        }));

        $('#attendee_last_name').bind("keyup keydown change focus focusout", (function() {
            $(".last_name").text($('#attendee_last_name').val())
        }));
        
        $('#attendee_twitter').bind("keyup keydown change focus focusout", (function() {
            $(".twitter_id").text("@"+$('#attendee_twitter').val())
            
            if ($('#attendee_twitter').val().length < 1) {
                $(".twitter_id").text('')
            }
            
        }));
    }
});