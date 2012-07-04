require 'reek/spec'

module ReekHelper
  def get_source_file(spec_file)
    File.open(spec_file.gsub(/_spec/,'').gsub(%r[spec/lib],'lib').gsub(/spec/,'app'))
  end
end

RSpec.configure do |specs|
  specs.include(Reek::Spec)
  specs.include(ReekHelper)
end
