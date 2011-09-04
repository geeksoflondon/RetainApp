# encoding: utf-8

class EventLogoUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  include CarrierWave::RMagick
  # include CarrierWave::ImageScience
  #include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Create different versions of your uploaded files:
  version :badge_logo do
    process :resize_to_fit => [300, 90]
  end

  version :edit_screen do
    process :resize_to_fit => [700, 200]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end


end
