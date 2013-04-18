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
    @identity = Fabricate(:identity_with_user,  email: email,
                                    password: password,
                                    username: username,
                                    sign_in_count: 2)
    @user = @identity.user
    self
  end

  def make_journal_entry
    page = Site.new_journal_entry_page.go
    @entry_title = Faker::Lorem.words(rand(3)+3).join(' ')
    page.title_field.set @entry_title
    @entry_body = Faker::Lorem.paragraphs(rand(2)+1).join("\n")
    page.body_field.set @entry_body
    page.post_entry_btn.click
  end

  def seeing_journal_entry?
    (Site.current_page.has_text? @entry_title) && (Site.current_page.has_text? @entry_body)
  end

  def method_missing(meth_name, *args)
    if @user
      return @user.send(meth_name, *args) if @user.respond_to? meth_name

    elsif @identity
      return @identity.send(meth_name, *args) if @identity.respond_to? meth_name

    end
    super
  end
end
