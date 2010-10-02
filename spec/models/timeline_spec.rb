require 'spec_helper'

describe Timeline do

  it "should not be valid without a name" do
    t = Timeline.make
    t.should_not be_valid
  end

  it "should embed events" do
    t = Timeline.make
    t.name = Faker::Lorem.words(3)
    t.events = Event.make(3)
    t.events.length.should eql(3)
  end
end
