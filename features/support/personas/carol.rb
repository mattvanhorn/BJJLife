require_relative './person'

class Carol < Person
  attribute :teacher,   String
  attribute :rank,      String

  def initialize
    self.username = "Carol Burgers"
    self.email = "carol@example.com"
    self.password = "password"
    self.teacher = "Renzo Gracie"
    self.rank = "Purple Belt"
  end

  def create
    Fabricate(:identity_with_user_in_market,  email: email,
                                              password: password,
                                              username: username,
                                              market: Market.last,
                                              sign_in_count: 2)
    self
  end

end
