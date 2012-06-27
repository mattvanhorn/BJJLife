namespace :coverage do

  desc "Generates and opens code coverage report."
  task :report do
    `open #{Rails.root}/coverage/index.html`
  end
end

task :test do
  Rake::Task['coverage:report'].invoke
end

task :spec do
  Rake::Task['coverage:report'].invoke
end

task :cucumber do
  Rake::Task['coverage:report'].invoke
end

task :all do
  Rake::Task['coverage:report'].invoke
end

