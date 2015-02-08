class Topic < ActiveRecord::Base
  belongs_to :board, inverse_of: :topics
  has_many :posts, inverse_of: :topic
end
