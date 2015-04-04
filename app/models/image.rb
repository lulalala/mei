class Image < ActiveRecord::Base
  belongs_to :post, inverse_of: :images

  mount_uploader :image, ImageUploader
end
