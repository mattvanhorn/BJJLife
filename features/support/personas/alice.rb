require_relative './person'
class Alice < Person

  attribute :teacher,   String
  attribute :rank,      String

  def initialize
    self.username = "Alice K"
    self.email = "another_alice@example.com"
    self.password = "password"
    self.teacher = "Vitor 'Shaolin' Ribeiro"
    self.rank = "Blue Belt"
  end

  def create
    Fabricate(:identity_with_user, email: email,
                                   password: password,
                                   sign_in_count: 0)
    self
  end

  def update_profile
    page.nickname_field.set username
    page.teacher_field.set teacher
    page.rank_field.set rank
    page.update_btn.click
  end

end
