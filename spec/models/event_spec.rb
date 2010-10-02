require 'spec_helper'

describe Event do

  it "should require a date, a title, and a short description" do
    e = Event.make
    e.should_not be_valid

    e.event_date = "2010/9/30 0:0:0"
    e.title = "The title"
    e.short_description = "short description"
    e.should be_valid
  end

end

