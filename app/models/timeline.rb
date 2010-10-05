class Timeline
  include Mongoid::Document

  field :name
  field :description

  embeds_many :events, :default => []

  validates_presence_of :name
  validates_presence_of :description
end
