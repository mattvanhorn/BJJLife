class ApplicationController < ActionController::Base
  protect_from_forgery

  analytical :modules => [:console, :google], :use_session_store => true, :disable_if => lambda{|controller| controller.class.ancestors.include?(Admin)}

end
