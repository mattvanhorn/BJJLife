require 'active_support/inflector'

class OmniAuthenticator
  String.extend ActiveSupport::Inflector

  attr_reader :provider, :uid

  def initialize(auth_hash)
    @provider = auth_hash['provider']
    @uid = auth_hash['uid']
  end

  def method_missing(method_sym, *args, &block)
    match = FinderMatch.new(method_sym)
    if match.match?
      target = match.target
      look_up(target) || make_new(target)
    else
      super
    end
  end

  def respond_to?(method_sym, include_private = false)
    FinderMatch.new(method_sym).match? || super
  end

  private

  class FinderMatch
    attr_reader :target
    def initialize(method_sym)
      if method_sym.to_s =~ /^find_(\w+)$/
        @target = $1.to_sym
      end
    end

    def match?
      !!(@target)
    end
  end

  def auth_class
    @_auth_class ||= provider.classify.constantize
  end

  def auth_credentials
    @_auth_cred ||= auth_class.find_by_uid(uid)
  end

  def look_up(target)
    auth_credentials.send(target)
  end

  def make_new(target)
    (result = auth_credentials.send(:"build_#{target}")) && auth_credentials.save!
    result
  end

end