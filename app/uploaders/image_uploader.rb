# frozen_string_literal: true

class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process :remove_animation
    process resize_to_fit: [250, 250]
    process :watermark
    process :store_thumb_dimensions
  end

  process :store_dimensions

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    if model.remote_image_url.present?
      nil # extension check moved to Image model
    else
      %w[jpg jpeg gif png]
    end
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    if original_filename
      if model && model.read_attribute(mounted_as).present?
        model.read_attribute(mounted_as)
      else
        base = file.send(:split_extension, original_filename).first
        "#{Time.now.to_i}_#{base[0..16]}.#{get_extension}"
      end
    end
  end

  def get_extension
    FastImage.type(file.to_file)
  end

  def watermark
    manipulate! do |img|
      return img unless img.mime_type.include?('gif')

      img.combine_options do |cmd|
        cmd.gravity 'SouthEast'
        cmd.draw 'text 10,10 "GIF"'
        cmd.font Setting.dig(:carrierwave, :watermark, :font)
        cmd.pointsize '24'
        cmd.fill 'black'
      end
    end
  end

  def remove_animation
    manipulate! do |img|
      img.collapse! if img.mime_type.match?(/gif/)
      img
    end
  end

  def store_dimensions
    if file && model
      model.width, model.height = ::MiniMagick::Image.open(file.file)[:dimensions]
    end
  end

  def store_thumb_dimensions
    if file && model
      model.thumb_width, model.thumb_height = ::MiniMagick::Image.open(file.file)[:dimensions]
    end
  end
end
