class Image < ActiveRecord::Base
  belongs_to :post, inverse_of: :images

  mount_uploader :image, ImageUploader

  validate :pre_upload_check
  def pre_upload_check
    if @invalid_reason.present?
      errors.add(:image, @invalid_reason)
    end
  end

  def remote_image_url=(url)
    self.remote_url = url

    # Check file type and size before Carrierwave fetches it.
    # Store invalid reason for Rails validation later on.
    checker = FastImage.new(url)
    @invalid_reason = nil

    if checker.content_length.present? && checker.content_length > 5.megabytes
      @invalid_reason = "file size too big"
    elsif checker.type.nil?
      @invalid_reason = "not an image file"
    end

    if @invalid_reason.nil?
      super
    else
      nil
    end
  end

  # @return file size in bytes
  def file_size
    result = `du -c -b #{Pathname.new(image.current_path).parent.to_s}`
    result.lines.last.split("\t").first.to_i
  end
end
