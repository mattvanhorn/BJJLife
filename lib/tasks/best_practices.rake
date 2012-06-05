begin
  require 'rails_best_practices'

  desc "Generates best practices report."
  task :best_practices do
    output_file = File.join(Rake.application.original_dir, 'quality', 'rails_best_practices.html')
    analyzer = RailsBestPractices::Analyzer.new(Rake.application.original_dir, {
      "format" => 'html',
      "with-textmate" => true,
      "output-file" => output_file
    })
    analyzer.analyze
    analyzer.output
    `open #{output_file}`
    fail "found bad practices" if analyzer.runner.errors.size > 0

  end
rescue LoadError
  # DO NOTHING - THIS IS PROBABLY HAPPENING BECAUSE WE'RE RUNNING ON HEROKU
end