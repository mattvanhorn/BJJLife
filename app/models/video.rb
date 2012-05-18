require 'active_model'

class Video
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :name
  attr_accessor :url

  class << self
    attr_accessor :collection
  end

  def initialize(attrs = {})
    self.class.collection ||= []
    attrs.each do |k,v|
      self.send(:"#{k}=", v)
    end
    self.class.collection << self
  end

  def id
    url
  end

  def eql?(other)
    self.class.equal?(other.class) &&
      name == other.name &&
      url == other.url
  end
  alias == eql?

  def hash
    name.hash ^ url.hash
  end

  def self.all
    collection.uniq
  end
end