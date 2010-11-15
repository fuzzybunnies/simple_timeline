class Timeline
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :description

  embeds_many :events, :default => []
  referenced_in :user

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :user
end
