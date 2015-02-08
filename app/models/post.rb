class Post < ActiveRecord::Base
  belongs_to :topic, inverse_of: :posts
end
