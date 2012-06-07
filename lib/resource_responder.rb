class ResourceResponder < ActionController::Responder
  include Responders::FlashResponder
  include Responders::HttpCacheResponder
end
