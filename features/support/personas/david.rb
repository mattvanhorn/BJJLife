require_relative './person'

class David < Person
  attribute :teacher,   String
  attribute :rank,      String

  def initialize
    self.username = "David Dollar"
    self.email = "david@example.com"
    self.password = "password"
    self.teacher = "Eddie Bravo"
    self.rank = "Brown Belt"
  end

  def create
    Fabricate(:identity_with_user_in_market,  email: email,
                                              password: password,
                                              username: username,
                                              market: Fabricate(:market),
                                              sign_in_count: 2)
    self
  end

end
