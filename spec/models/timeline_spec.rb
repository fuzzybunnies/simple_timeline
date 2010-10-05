require 'spec_helper'

describe Timeline do

  it "should not be valid without a name and description" do
    t = Timeline.make
    t.should_not be_valid
    t.name = "test"
    t.should_not be_valid
    t.name = nil
    t.description = "test"
    t.should_not be_valid
  end

  it "should be valid with a name and a description" do
    t = Timeline.make(:name => 'test', :description => 'test')
    t.should be_valid
  end

  it "should embed events" do
    t = Timeline.make
    t.name = Faker::Lorem.words(3)
    t.events = Event.make(3)
    t.events.length.should eql(3)
  end
end
