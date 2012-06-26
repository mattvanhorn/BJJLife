class GuestUser
  attr_accessor :market, :location

  def initialize(id)
    @id = id
  end

  def id
    @id
  end
end