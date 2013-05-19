require 'exhibit_spec_helper'
require_relative '../../app/exhibits/academy_group_exhibit'

describe "AcademyGroupExhibit" do
  let(:fake_class){ double('klass', :name => 'AcademyGroup') }

  subject { AcademyGroupExhibit }

  before(:each) do
    stub_const("AcademyGroup", fake_class)
    AcademyGroup.stub(:new).and_return(double('AcademyGroup', :class => fake_class))
  end

  it { should apply_to(AcademyGroup.new('NY', [])) }
end

describe AcademyGroupExhibit do
  Delegator.class_eval { include RSpec::Mocks::Methods }

  subject(:exhibit){ AcademyGroupExhibit.new(academy_group, context) }

  let(:context)       { Object.new }
  let(:academy_group) { OpenStruct.new(:academies => academies) }
  let(:academies)     { Object.new }

  describe "academies" do
    it 'exhibits its academies' do
      exhibited_academies = Object.new
      exhibit.should_receive(:exhibit).with(academies).and_return(exhibited_academies)
      exhibit.academies.should equal(exhibited_academies)
    end
  end

  describe "rendering" do
    it "renders the right partial" do
      context.should_receive(:render).with(hash_including(partial: 'academy_groups/academy_group'))
      exhibit.render(context)
    end
    it "passes itself to the partial" do
      context.should_receive(:render).with(hash_including(locals: {academy_group: exhibit, css: ''}))
      exhibit.render(context)
    end
  end

  describe "rendering as a navigation link" do
    it "renders the right partial" do
      context.should_receive(:render).with(hash_including(partial: 'academy_groups/academy_group_link'))
      exhibit.render_as_link(context)
    end
    it "passes itself to the partial" do
      context.should_receive(:render).with(hash_including(locals: {academy_group: exhibit}))
      exhibit.render_as_link(context)
    end
  end
end
