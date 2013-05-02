require 'active_support/core_ext/string'

module CommonPageBehavior
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def init_url_and_matcher(url)
      set_url url
      set_url_matcher %r(#{url})
    end
  end

  def find_by_name(collection, method, name)
    send(collection).detect{ |element| (method ? element.send(method) : element).has_text? name}
  end
end

module IndexPageBehavior
  def self.included(base)
    base.extend ClassMethods
    base.class_exec do
      elements collection_name.to_sym, "table##{collection_name} tr.#{model_name}"
      define_method "delete_#{model_name}" do |name|
        load
        delete_link_for(model_element(name)).click
      end
    end
  end

  module ClassMethods
    def model_name
      collection_name.singularize
    end
    def collection_name
      self.name.sub(/Page$/,'').underscore.split('/').last
    end
  end

  def model_element(text)
    send(self.class.collection_name).detect{|c| c.has_text? text }
  end

  def delete_link_for(page_element)
    page_element.find('a[data-method="delete"]')
  end
end
