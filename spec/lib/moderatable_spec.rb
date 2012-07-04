require 'spec_helper'

class MyModeratable
  attr_accessor :state
  def self.scope(*args); end
  def self.where(*args); end
  include Moderatable
end

describe Moderatable do

  subject { MyModeratable.new }

  it "responds to pending?" do
    subject.should be_pending
  end

  it "responds to published?" do
    subject.should_not be_published
  end

  it "can be published" do
    subject.publish!
    subject.should be_published
  end

end
