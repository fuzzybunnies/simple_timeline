require 'spec_helper'


describe Event do

  before(:each) do
    @e = Event.make
  end

  it 'should set the is_year_only field to true if a 4 digit year is input as the event_date' do
    @e.event_date = '1492'
    @e.is_year_only.should be_true
  end

  it 'should set the is_year_only field to true if a 3 digit year is input as the event_date' do
    @e.event_date = '149'
    @e.is_year_only.should be_true
  end

  it 'should set the event_date to 1/1 is only a 4 digit year is input' do
    @e.event_date = '1492'
    @e.event_date.year.should eql(1492)
    @e.event_date.month.should eql(1)
    @e.event_date.day.should eql(1)
  end
  it 'should set the event_date to 1/1 is only a 3 digit year is input' do
    @e.event_date = '492'
    @e.event_date.year.should eql(492)
    @e.event_date.month.should eql(1)
    @e.event_date.day.should eql(1)
  end
  it "should require a date, a title, and a short description to be valid" do
    e = Event.make
    e.should_not be_valid
    e.event_date = "2010/9/30 0:0:0"
    e.should_not be_valid
    e.title = "The title"
    e.should_not be_valid
    e.short_description = "short description"
    e.should be_valid
  end

  it 'should have an event_date field' do
    @e.respond_to?(:event_date).should be_true
  end

  it 'should have a title field' do
    @e.respond_to?(:title).should be_true
  end

  it 'should have a short_description field' do
    @e.respond_to?(:short_description).should be_true
  end

  it 'should have a detailed_description field' do
    @e.respond_to?(:detailed_description).should be_true
  end

  it 'should have a is_year_only field' do
    @e.respond_to?(:is_year_only).should be_true
  end

  it 'should have a timeline field' do
    @e.respond_to?(:timeline).should be_true
  end

  it 'should have an images field' do
    @e.respond_to?(:images).should be_true
  end

  it 'should have an ascending index on the event_date field' do
    event_date_found = false
    @e.index_options.each { |key, value|
      key.each { |field_definition|
        field = field_definition.first
        option = field_definition.last
        if field == 'event_date'.to_sym 
          event_date_found = true
          option.should eql(1)
        end
      }
    }

    event_date_found.should be_true
  end

  it 'should have a timeline as a parent' do
    timeline = Timeline.make(:valid)
    timeline.events << Event.make(:valid)
    timeline.save!

    Timeline.find(timeline.id).events.first.timeline.should eql(timeline)

    timeline.destroy 
  end

  it 'should have an images field' do
    e = Event.new
    e.respond_to?(:images).should be_true
  end

  it 'should create an event w/ an attached image' do
    timeline = Timeline.make(:valid)
    timeline.events << Event.make(:valid)
    timeline.save!

    e = timeline.events.first
    image_file = File.new(File.join(Rails.root, "spec","support", "test_images", "skater.jpg"))

    e.images << Image.new(:image => image_file)

    timeline.save

    timeline.events.first.images.first.image_url.should_not be_nil


    timeline.destroy
  end

end

