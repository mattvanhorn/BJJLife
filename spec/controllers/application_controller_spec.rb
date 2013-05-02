require "spec_helper"

describe ApplicationController do
  let(:secret){ Bjjlife::Application.config.secret_token }
  let(:verifier){ ActiveSupport::MessageVerifier.new(secret) }

  describe "#identifiable_user" do
    subject { controller.send :identifiable_user }
    context "when user is signed in" do
      before { controller.stub(:current_user => double('user_decorator', :id => 42)) }
      its(:id) { should == 42 }
    end
    context "when user is not signed in" do
      before { controller.stub(:current_user => nil) }
      it { should be_a(GuestUser) }
    end
  end

  describe "signing in a user" do
    controller do
      def index
        sign_in(User.find(42))
        render :nothing => true
      end
    end

    let(:user){ mock_model(User, :id => 42).as_null_object }

    before(:each) do
      User.stub(:find => user)
    end

    it "sets a session user_id " do
      get :index
      session[:user_id].should == 42
    end

    it "sets a cookie" do
      get :index
      verifier.verify(response.cookies['remember_me']).should == 42
    end
  end

  describe "signing out a user" do
    controller do
      def index
        sign_out
        render :nothing => true
      end
    end

    it "clears the session user_id " do
      get :index
      session[:user_id].should be_nil
    end

    it "clears the cookie" do
      get :index
      response.cookies['remember_me'].should be_nil
    end
  end

  describe "locating users" do
    controller do
      def index
        render :nothing => true
      end
      def test_guest_user
        guest_user
      end
    end

    let(:current_user){ double('user', :located? => false) }
    let(:request_location){ Object.new }

    before(:each) do
      Rails.application.config.stub(:locate_users => true)
      request.stub(:location => request_location)
    end

    it "sets current user's location" do
      controller.stub(:user_signed_in? => true, :current_user => current_user)
      current_user.should_receive(:set_location).with(request_location).and_return(true)
      get :index
    end

    it "sets guest user's location in a cookie" do
      controller.stub(:user_signed_in? => false)
      Location.should_receive(:attributes_from_gecoder_result).with(request_location).and_return({:foo => 'bar'})
      get :index
      verifier.verify(response.cookies['location']).should == "---\n:foo: bar\n"
    end
  end

  describe "guest_users" do
    let(:location){ mock_model(Location) }
    let(:market)  { mock_model(Market) }
    let(:coords)  { {:lat => 42.0, :lng => -69.0} }

    controller do
      def get_guest_user
        guest_user
      end
    end

    before(:each) do
      request.cookies['guest_id'] = verifier.generate(123)
      request.cookies['location'] = verifier.generate(coords.to_yaml)
      Location.stub(:new).and_return(location)
      Market.stub(:near).and_return([market])
    end

    it "sets a guest user's location" do
      Location.should_receive(:new).with(:lat => 42.0, :lng => -69.0).and_return(location)
      guest_user = controller.get_guest_user
      guest_user.location.should == location
    end

    it "sets a guest user's market" do
      Market.should_receive(:near).with(location).and_return([market])
      guest_user = controller.get_guest_user
      guest_user.market.should == market
    end
  end
end
