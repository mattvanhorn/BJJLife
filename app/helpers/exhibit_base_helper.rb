module ExhibitBaseHelper

  def eql?(other)
    if other.respond_to?(:to_model)
      self.class.new.kind_of?(other.class) && (self.to_model == other.to_model)
    else
      super
    end
  end
  alias :== eql?

  # NOTE: This makes me a little nervous, but I think it is better than nil checks everywhere.
  def nil?
    respond_to?(:to_model) ? to_model.nil? : super
  end

  private

  def in_view
    @context.respond_to?(:view_context) ? @context.view_context : @context
  end

end

