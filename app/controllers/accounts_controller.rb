class AccountsController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :create]

  expose(:identity){ (current_user.identity if user_signed_in?) || Identity.new }

  before_filter :exhibit_exposed_identity, :except => [:update]

  def show
    # just render
  end

  def new
    # just render
  end

  def edit
    # just render
  end

  def update
    current_user.update_attributes(params[:user])
    exhibit_exposed_identity
    respond_with current_user, :location => account_url
  end

  private

  def exhibit_exposed_identity
    exhibit_exposed :identity
  end
end