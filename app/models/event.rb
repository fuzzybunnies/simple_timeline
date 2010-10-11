class Event
  include Mongoid::Document

  field :event_date, :type => DateTime
  field :title
  field :short_description
  field :detailed_description

  embedded_in :timeline, :inverse_of => :events

  attr_accessible :event_date, :title, :short_description, :detail_description

  validates_presence_of :event_date, :title, :short_description
end
