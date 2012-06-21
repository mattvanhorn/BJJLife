class CategoryExhibit < DisplayCase::Exhibit
  def self.applicable_to?(object)
    object.class.name == 'Category' || object.nil? || (object.respond_to?(:to_model) && object.to_model.nil?)
  end

  def name
    "#{super unless to_model.nil?}"
  end

  def to_s
    name
  end

  def to_css_class
    name.gsub(/[^\w]+/, '-').downcase
  end

  def nil?
    to_model.nil?
  end
end


