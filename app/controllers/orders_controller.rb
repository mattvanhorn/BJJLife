class OrdersController < ApplicationController
  self.responder = ResourceResponder

  expose(:product){ Product.find_by_id(params[:product_id]) }
  expose(:order){ Order.find_by_id(params[:id]) || (current_user ? current_user.new_order(params[:order]) : Order.new(params[:order])) }

  def new
    order.email = current_user.email if user_signed_in?
    exhibit_exposed :product, :order
  end

  def create
    do_checkout
    exhibit_exposed :product, :order
    respond_with order
  end

  def show
    exhibit_exposed :product, :order
  end

  protected

  def do_checkout
    identity = do_registration unless user_signed_in?
    order.add_item(product)
    order.checkout
    order.merge_identity_errors(identity.errors) unless order.paid?
  end

  def do_registration
    sign_in_params = params[:identity].merge(:email => params[:order][:email], :opt_in => true)
    Identity.new(sign_in_params) do |identity|
      sign_in(identity.user) if identity.save
    end
  end

end
