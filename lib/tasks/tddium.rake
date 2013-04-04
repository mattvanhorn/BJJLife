def cmd(c)
  system c
end

namespace :tddium do
  desc "post_build_hook"
  task :post_build_hook do
    # This build hook should only run after CI builds.
    #
    # There are other cases where we'd want to run something after every build,
    # or only after manual builds.
    return unless ENV["TDDIUM_MODE"] == "ci"
    return unless ENV["TDDIUM_BUILD_STATUS"] == "passed"

    dir = File.expand_path("~/.heroku/")
    heroku_email = ENV["HEROKU_EMAIL"]
    heroku_api_key = ENV["HEROKU_API_KEY"]
    current_branch = `git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3-`.strip
    app_name = ENV["HEROKU_APP_NAME"]
    push_target = "git@heroku.com:#{app_name}.git"

    abort "invalid current branch" unless current_branch

    FileUtils.mkdir_p(dir) or abort "Could not create #{dir}"

    puts "Writing Heroku Credentials"
    File.open(File.join(dir, "credentials"), "w") do |f|
      f.write([heroku_email, heroku_api_key].join("\n"))
      f.write("\n")
    end

    File.open(File.expand_path("~/.netrc"), "a+") do |f|
      ['api', 'code'].each do |host|
        f.puts "machine #{host}.heroku.com"
        f.puts "  login #{heroku_email}"
        f.puts "  password #{heroku_api_key}"
      end
    end

    puts "Pushing to Heroku: #{push_target}..."
    cmd "git push #{push_target} HEAD:master --force" or abort "could not push to #{push_target}"

    puts "Running Heroku Migrations..."
    cmd "heroku run rake db:migrate --app #{app_name}" or abort "aborted migrations"

    puts "Restarting Heroku..."
    cmd "bundle exec heroku restart --app #{app_name}" or abort "aborted heroku restart"
  end
end
