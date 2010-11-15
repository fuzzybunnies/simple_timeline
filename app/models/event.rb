require 'chronic'

class Event
  include Mongoid::Document

  field :event_date, :type => DateTime
  field :title, :type => String
  field :short_description, :type => String
  field :detailed_description, :type => String
  index [[:event_date, Mongo::ASCENDING]]
  field :is_year_only, :type => Boolean, :default => false

  embedded_in :timeline, :inverse_of => :events
  embeds_many :images, :default => []

  attr_accessible :event_date, :title, :short_description, :detailed_description

  validates :event_date, :presence => { :message => "doesn't appear to be formatted properly" }
  validates :title, :presence => true
  validates :short_description, :presence => true

  def event_date=(value)
    if Regexp.new(/^\d{4}$/).match(value)
      value = "1/1/#{value}"
      self.is_year_only = true
    end
    processed = Chronic::parse(value)
    write_attribute("event_date", processed)
  end      

end
