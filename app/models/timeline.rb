class Timeline
  include Mongoid::Document

  field :name

  embeds_many :events, :default => []

  validates_presence_of :name
end
