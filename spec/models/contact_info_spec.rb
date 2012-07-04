require_relative "../../app/models/contact_info"

describe ContactInfo do
  let(:contact_info){ ContactInfo.new("foo", "bar", "baz") }

  subject { contact_info }

  its(:email){ should == 'foo' }

  its(:phone_number){ should == 'bar' }

  its(:website){ should == 'baz' }
end
