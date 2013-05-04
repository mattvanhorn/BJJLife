class AcademyValidator < CustomValidator
  def validate(obj)
    super
    opts = options
    validators = [
      ActiveModel::Validations::PresenceValidator.new(opts.merge(:attributes => [:name])),
      ActiveModel::Validations::LengthValidator.new(opts.merge(:attributes => [:email], :in => (3..254), :allow_blank => true)),
      EmailValidator.new(opts.merge(:attributes => [:email], :allow_blank => true)),
      ContactMethodValidator.new(opts)
    ]
    validators.each do |validator|
      validator.validate(@record)
    end
  end
end
