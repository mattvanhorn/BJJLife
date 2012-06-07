class OrderMailer < ActionMailer::Base
  default from: "mattvanhorn@gmail.com"

  def confirmation(order)
    @order = order
    mail(:to => @order.email, :subject => "Your Order Confirmation")
  end
end
