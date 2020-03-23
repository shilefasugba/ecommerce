STRIPE_ID = 'cus_7ZQaBLV1U0TEPm'
Stripe.api_key = "sk_test_IAyhDJRc0UCNcFXXDzEvOeYC"

StripeEvent.configure do |events|
  events.subscribe 'charge.failed', ChargeFailed.new
  events.subscribe 'charge.succeeded', ChargeSuccess.new
end