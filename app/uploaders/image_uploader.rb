require 'carrierwave/processing/mini_magick'

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  version :medium do
    process :resize_to_fit => [320,320] 
  end
  version :thumb do
    process :resize_to_fill => [80,80]
  end
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
