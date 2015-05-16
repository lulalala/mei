class Topic < ActiveRecord::Base
  belongs_to :board, inverse_of: :topics
  has_many :posts, inverse_of: :topic, dependent: :destroy

  nilify_blanks

  before_create :set_bumped_at
  def set_bumped_at
    self.bumped_at = Time.now
  end
end
