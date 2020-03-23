Order = {
  toggleAddresses: function(el) {
    let wr = $('.' + el.id + '_fields');

    if($(el).val() === ''){
      wr.show()
    } else {
      wr.hide()
    }
  },
  setupEvts: function () {
    let order_billing_address_id = $('#order_billing_address_id');
    let order_shipping_address_id = $('#order_shipping_address_id');

    $([order_billing_address_id, order_shipping_address_id]).each(function(){
      $(this).on('change', function () {
        Order.toggleAddresses(this)
      })
    });
  },
  init: function () {
    Order.setupEvts();
  }
};

$(function () {
  if($('.new_order').length || $('.edit_order').length) {
    Order.init();
  }
});
