Given "there are no registered users" do
  Identity.destroy_all
  User.destroy_all
end