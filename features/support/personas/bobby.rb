require_relative './person'

class Bobby < Person
  attribute :teacher,   String
  attribute :rank,      String

  def initialize
    self.username = "Bobby Tables"
    self.email = "bobby@example.com"
    self.password = "password"
    self.teacher = "Marcelo Garcia"
    self.rank = "White Belt"
  end

  def create
    Fabricate(:identity_with_user,  email: email,
                                    password: password,
                                    username: username,
                                    sign_in_count: 2)
    self
  end

end
