require 'spec_helper'

describe AcademyDecorator do

  subject { AcademyDecorator.decorate(model) }
  describe "providing an address" do
    let(:model){ mock_model(Academy, :street => 'aaa', :unit => 'bbb', :city => 'ccc', :us_state => 'DD', :postal_code => '12345') }

    it "provides an array of address lines" do
      subject.address.should == ['aaa, bbb', 'ccc, DD 12345']
    end
    it "handles blank or missing parts" do
      model.stub(:unit => nil, :postal_code => ' ')
      subject.address.should == ['aaa', 'ccc, DD']
    end
  end
  describe "providing contact info" do
    let(:model){ mock_model(Academy, :website => 'aaa', :phone_number => 'bbb', :email => 'a@b.com') }

    it "provides an array of address lines" do
      subject.contact.should == ['<a href="aaa">aaa</a>', 'bbb', '<a href="mailto:a@b.com">a@b.com</a>']
    end
    it "handles blank or missing parts" do
      model.stub(:website => nil, :phone_number => ' ')
      subject.contact.should == ['<a href="mailto:a@b.com">a@b.com</a>']
    end
  end
end
