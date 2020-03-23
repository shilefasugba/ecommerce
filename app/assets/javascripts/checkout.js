var subscription;
jQuery(function() {
  return subscription.setupForm();
});
subscription = {
  setupForm: function() {
    return $('#new_order').submit(function() {
      $('input[type=submit]').attr('disabled', true);
      if ($('#order_card_number').length) {
        subscription.processCard();
        return false;
      } else {
        return true;
      }
    });
  },
  processCard: function() {
    var card;
    card = {
      number: $('#order_card_number').val(),
      cvc: $('#order_card_code').val(),
      expMonth: $('#order_card_month').val(),
      expYear: $('#order_card_year').val()
    };
    return Stripe.createToken(card, subscription.handleStripeResponse);
  },
  handleStripeResponse: function(status, response) {
    var errorBlock;
    if (status === 200) {
      $('#order_stripe_card_token').val(response.id);
      return $('#new_order')[0].submit();
    } else {
      errorBlock = $('#stripe_error');
      errorBlock.removeClass('hidden');
      errorBlock.text(response.error.message);
      return $('input[type=submit]').attr('disabled', false);
    }
  }
};