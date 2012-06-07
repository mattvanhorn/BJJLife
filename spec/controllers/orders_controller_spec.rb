require 'spec_helper'

describe OrdersController do
  include NullDB::RSpec::NullifiedDatabase

  let(:order){ mock_model(Order).as_null_object }
  let(:product){ mock_model(Product) }


  before(:each) do
    Order.stub(:new => order)
    Product.stub(:find_by_id => product)
  end

  describe "#new" do
    let(:current_user){ mock_model(User, :email => 'alice@example.com') }
    before(:each) do
      controller.stub(  :user_signed_in? => true,
                        :current_user => current_user,
                        :order => order )
    end
    it "pre-populates the email if there is a signed in user" do
      order.should_receive(:email=).with('alice@example.com')
      get :new
    end

    it "renders the 'new' template" do
      get :new
      response.should render_template(:new)
    end
  end

  describe "#create" do
    let(:current_user){ mock_model(User, :email => 'alice@example.com') }

    let(:order_params){
      {:email => 'alice@example.com'}
    }

    let(:identity_params){
      { :password => 'seekrit', :password_confirmation => 'seekrit' }
    }

    context "with a signed in user" do
      let(:params){ HashWithIndifferentAccess.new(:order => order_params) }

      before(:each) do
        current_user.stub(:new_order => order)
        controller.stub( :user_signed_in? => true, :current_user => current_user )
      end

      it "creates the order for the current user" do
        current_user.should_receive(:new_order).and_return(order)
        post :create, params
      end

      it "adds the product to the order" do
        order.should_receive(:add_item).with(product)
        post :create, params
      end

      it "redirects to the purchase thank you page" do
        post :create, params
        response.should redirect_to(order_url(order))
      end
    end

    context "with a new user" do
      let(:new_user){ mock_model(User, :new_order => order).as_null_object  }
      let(:identity){ double('identity', :user => new_user).as_null_object }
      let(:params){ HashWithIndifferentAccess.new(:order => order_params, :identity => identity_params) }
      before(:each) do
        controller.stub( :user_signed_in? => false, :current_user => new_user)
        Identity.stub(:new => identity)
      end

      it "adds the product to the order" do
        order.should_receive(:add_item).with(product)
        post :create, :order => order_params, :identity => identity_params
      end

      it "registers the user" do
        Identity.should_receive(:new).and_yield(identity)
        post :create, :order => order_params, :identity => identity_params
      end

      it "builds the order for the user" do
        new_user.should_receive(:new_order).and_return(order)
        post :create, :order => order_params, :identity => identity_params
      end

      it "redirects to the purchase thank you page" do
        post :create, :order => order_params, :identity => identity_params
        response.should redirect_to(order_url(order))
      end
    end

    context "when the charge fails for an existing user" do
      let(:order){ double('order', :errors => ['some kind of error']).as_null_object }
      let(:params){ HashWithIndifferentAccess.new(:order => order_params) }

      before(:each) do
        current_user.stub(:new_order => order)
        controller.stub( :user_signed_in? => true, :current_user => current_user)
      end

      it "adds the product to the order" do
        order.should_receive(:add_item).with(product)
        post :create, :order => order_params, :identity => identity_params
      end

      it "adds the user to the order" do
        current_user.should_receive(:new_order).and_return(order)
        post :create, params
      end

      it "renders the checkout form" do
        post :create, :order => order_params, :identity => identity_params
        response.should be_success
        response.should render_template 'new'
      end
    end
  end
end


