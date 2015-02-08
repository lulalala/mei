class Board < ActiveRecord::Base
  has_many :topics, inverse_of: :board
end
