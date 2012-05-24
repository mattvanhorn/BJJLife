namespace :tddium do
  def cmd(c)
    system c
  end

  desc "post_build_hook"
  task :post_build_hook do
    cmd "git reset --hard HEAD" or fail "could not reset git workspace"

    dir = File.expand_path("~/.heroku/")
    heroku_email = ENV["HEROKU_EMAIL"]
    heroku_api_key = ENV["HEROKU_API_KEY"]
    current_branch = `git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3-`.strip
    app_name = ENV["HEROKU_APP_NAME"]
    push_target = "git@heroku.com:#{app_name}.git"

    fail "invalid current branch" unless current_branch

    FileUtils.mkdir_p(dir) or fail "Could not create #{dir}"

    puts "Writing Heroku Credentials"
    File.open(File.join(dir, "credentials"), "w") do |f|
      f.write([heroku_email, heroku_api_key].join("\n"))
      f.write("\n")
    end

    puts "Pushing to Heroku: #{push_target}..."
    cmd "git push #{push_target} #{current_branch}:master --force" or fail "could not push to #{push_target}"

    puts "Running Heroku Migrations..."
    cmd "heroku run rake db:migrate --trace --app #{app_name}" or fail "failed to run migrations"
  end
end
