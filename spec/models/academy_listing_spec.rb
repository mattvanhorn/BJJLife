require 'support/constant_stubbing'
require "active_model"
require "virtus"
require_relative "../../lib/validators/custom_validator"
require_relative "../../lib/validators/contact_method_validator"
require_relative "../../lib/validators/email_validator"
require_relative "../../app/models/academy_listing"

describe AcademyListing do
  let(:academy){ Object.new }

  it { should_not be_persisted }

  it "is not valid when new" do
    AcademyListing.new.should_not be_valid
  end

  it "is valid when the academy it wraps is valid" do
    academy.stub(:valid? => true)
    presenter = AcademyListing.new
    presenter.academy = academy
    presenter.should be_valid
  end

  it "is not valid when the academy it wraps is not valid" do
    academy.stub(:valid? => false)
    presenter = AcademyListing.new
    presenter.academy = academy
    presenter.should_not be_valid
  end

  describe "persisting" do
    let(:presenter){ AcademyListing.new }

    before(:each) do
      stub_class 'Academy'
      academy.stub(:build_location => Object.new)
    end

    it "saves the academy" do
      academy.stub(:valid? => true)
      Academy.should_receive(:new).and_return(academy)
      academy.should_receive(:save!)
      presenter.save.should be_true
    end

    it "doesn't save the academy when it is not valid" do
      academy.stub(:valid? => false)
      Academy.should_receive(:new).and_return(academy)
      academy.should_not_receive(:save!)
      presenter.save.should be_false
    end
  end


end
