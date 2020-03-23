// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery_ujs
//= require twitter/bootstrap
// require popper
// require bootstrap
//= require tinymce
//= require tinymce-jquery
//= require_tree .

window.toogleAddresses = function(el){
    var wr = $('.' + el.id + '_fields')

    if($(el).val() == ''){
      wr.show()
    } else {
      wr.hide()
    }
  }

$(function(){
  $('#order_billing_address_id, #order_shipping_address_id').on('change', function(){
    window.toogleAddresses(this)   
  });

  $.each($('#order_billing_address_id, #order_shipping_address_id'), function(index, item) {
    window.toogleAddresses(item)    
  });
});
