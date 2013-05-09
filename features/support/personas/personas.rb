class Persona
  @cast_members = {}

  def self.method_missing(meth_name, *args)
    meth_name.to_s.titleize.constantize.new
  end

  def self.called(name)
    @cast_members[name] ||= send name.downcase
  end
end
