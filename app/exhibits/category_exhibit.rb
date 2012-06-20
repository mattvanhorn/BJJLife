class CategoryExhibit < DisplayCase::Exhibit
  def self.applicable_to?(object)
    true #object.class.name == 'Category' || object.nil?
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

end


