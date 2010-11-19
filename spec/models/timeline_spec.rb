require 'spec_helper'

describe Timeline do
  
  it 'should have timestamp fields' do
    t = Timeline.make
    t.respond_to?(:created_at).should be_true
    t.respond_to?(:updated_at).should be_true
  end

  it 'should have a user field' do
    t = Timeline.make
    t.respond_to?(:user).should be_true
  end

  it 'should have a user_id field' do
    t = Timeline.make
    t.respond_to?(:user_id).should be_true
  end

  it 'should require a name, desc, and user to be valid' do
    t = Timeline.make
    t.should_not be_valid
    t.name = Faker::Lorem.name
    t.description = Faker::Lorem.sentence
    t.should_not be_valid
    t.user = User.make
    t.should be_valid
  end

  it "should embed events" do
    t = Timeline.make(:valid)
    t.events << Event.make(:valid)
    t.save
    t.events.first.should_not be_nil
  end
end
