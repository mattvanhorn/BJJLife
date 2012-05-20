class Admin::BaseController < ApplicationController
  before_filter :authenticate

end