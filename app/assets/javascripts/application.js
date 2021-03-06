// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui  
//= require jquery-ui/accordion
//= require jquery-ui/datepicker
//= require nprogress
//= require nprogress-turbolinks
//= require_tree .

function showNotifications(){ 
  $nt = $(".alert"); 
  setTimeout("$nt.addClass('in')",500);
  setTimeout("$nt.removeClass('in').addClass('out')",5000);
}
	
var delay = (function(){
  var timer = 0;
  return function(callback, ms){
    clearTimeout (timer);
    timer = setTimeout(callback, ms);
  };
})();


var show_ajax_message = function(msg, type) {
    if (!type) {type = "success"};
    $(".js-notes").html( '<div class="alert flash_'+type+'">'+msg+'<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a></div>');    
    showNotifications();
};

