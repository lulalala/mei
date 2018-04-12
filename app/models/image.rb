# frozen_string_literal: true

class Image < ApplicationRecord
  belongs_to :post, inverse_of: :images, optional: true

  mount_uploader :image, ImageUploader

  validate :pre_upload_check
  def pre_upload_check
    errors.add(:image, @invalid_reason) if @invalid_reason.present?
  end

  def remote_image_url=(url)
    self.remote_url = url

    # Check file type and size before Carrierwave fetches it.
    # Store invalid reason for Rails validation later on.
    checker = FastImage.new(url)
    @invalid_reason = nil

    if checker.content_length.present? && checker.content_length > 5.megabytes
      @invalid_reason = :file_size_too_big
    elsif checker.type.nil?
      @invalid_reason = :invalid_image_file
    end

    super if @invalid_reason.nil?
  end

  # @return file size in bytes
  def file_size
    result = `du -c -b #{Pathname.new(image.current_path).parent.to_s}`
    result.lines.last.split("\t").first.to_i
  end
end
