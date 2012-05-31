require 'spec_helper'

describe Identity do
  it "is useable by the OmniAuthenticator" do
    Identity.should_receive(:find_by_id).with('42')
    Identity.find_by_uid('42')
  end
end
