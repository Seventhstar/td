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
//= require turbolinks
//= require_tree .


var showNotifications = function(){ 
  var time = 5000;
  $nt = $(".alert"); 
  if ($nt.hasClass('flash_success')){ time = 2000; }
  setTimeout(function() {
    $nt.removeClass("in"); 
    setTimeout("$nt.addClass('out')",1000);
  }, time);
}

var show_ajax_message = function(msg, type) {
    if (!type) {type = "success"};
    $(".js-notes").html( '<div class="alert fade-in flash_'+type+'">'+msg+'</div>');    
    showNotifications();
};
