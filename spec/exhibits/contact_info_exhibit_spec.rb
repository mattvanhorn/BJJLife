require 'display_case'
require 'ostruct'
require_relative '../../app/exhibits/contact_info_exhibit'

describe ContactInfoExhibit do
  let(:context)  { Object.new }
  let(:contact_info){ OpenStruct.new(:website => 'http://www.example.com', :phone_number => '212-555-1234', :email => 'alice@example.com') }
  let(:exhibit)  { ContactInfoExhibit.new(contact_info, context) }

  subject { exhibit }

  it "has a website link" do
    context.should_receive(:link_to).with('http://www.example.com', 'http://www.example.com').and_return('RIGHT_WEB_LINK')
    exhibit.website_link.should == "RIGHT_WEB_LINK"
  end
  it "has a phone link" do
    context.should_receive(:link_to).with('212-555-1234','tel://212-555-1234').and_return('RIGHT_PHONE_LINK')
    exhibit.phone_link.should == "RIGHT_PHONE_LINK"
  end
  it "has an email link" do
    context.should_receive(:mail_to).with('alice@example.com','alice@example.com').and_return('RIGHT_EMAIL_LINK')
    exhibit.email_link.should == 'RIGHT_EMAIL_LINK'
  end

end
