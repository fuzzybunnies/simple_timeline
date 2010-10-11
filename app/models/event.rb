require 'chronic'

class Event
  include Mongoid::Document

  field :event_date, :type => DateTime
  field :title
  field :short_description
  field :detailed_description

  embedded_in :timeline, :inverse_of => :events

  attr_accessible :event_date, :title, :short_description, :detail_description

  validates :event_date, :presence => { :message => "doesn't appear to be formatted properly" }
  validates :title, :presence => true
  validates :short_description, :presence => true

  def event_date=(value)
    processed = Chronic::parse(value)
    unless processed.nil?
      write_attribute("event_date", processed)
    end
  end      

end
