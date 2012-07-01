# encoding: utf-8

class EventLogoUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :fog

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

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
