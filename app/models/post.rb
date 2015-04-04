class Post < ActiveRecord::Base
  belongs_to :topic, inverse_of: :posts
  has_many :images, inverse_of: :post

  accepts_nested_attributes_for :images
end
