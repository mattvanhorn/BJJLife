jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  order.setupForm()

order =
  setupForm: ->
    $('#new_order').submit ->
      $('input[type=submit]').attr('disabled', true)
      order.processCard()

  processCard: ->
    card =
      name:     $('#bill_first_name').val() + ' ' + $('#bill_last_name')

      number:   $('#card_number').val()
      cvc:      $('#card_code').val()
      expMonth: $('#cc_exp_month').val()
      expYear:  $('#cc_exp_year').val()

      address_line1:  $('#bill_street').val()
      address_line2:  $('#bill_unit').val()
      address_state:  $('#bill_us_state').val()
      address_zip:    $('#bill_postal_code').val()

    Stripe.createToken(card, order.handleStripeResponse)
    return false

  handleStripeResponse: (status, response) ->
    if status == 200
      $('#order_stripe_card_token').val(response.id)
      $('#new_order')[0].submit()
    else
      $('form .field_with_errors .error').remove()
      $('form .field_with_errors').removeClass('field_with_errors')

      code = response.error.code
      msg  = response.error.message
      param = response.error.param
      switch param
        when "number"
          order.displayError('#card_number', msg)

        when "exp_month"
          order.displayError('#cc_exp_month', msg)

        when "exp_year"
          order.displayError('#cc_exp_year', msg)

        when "cvc"
          order.displayError('#card_code', msg)

        else
          $('#stripe_error').append(msg)
      $('input[type=submit]').attr('disabled', false)

  displayError: (field, message) ->
    $(field).parent().addClass('field_with_errors');
    $(field).after($('<span></span>').addClass('error').append(message))
