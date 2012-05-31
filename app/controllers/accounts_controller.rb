class AccountsController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :create]

  expose(:identity){ (current_user.identity if user_signed_in?) || Identity.new }

  def new
    # just render
  end

  def edit
    # just render
  end

  def update
    current_user.update_attributes(params[:user])
    respond_with current_user, :location => root_url
  end
end