require 'carrierwave/orm/mongoid'

class Image
  include Mongoid::Document
  include Mongoid::Timestamps


  embedded_in :event, :inverse_of => :images

  mount_uploader :image, ImageUploader



end
