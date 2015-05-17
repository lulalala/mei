class Board < ActiveRecord::Base
  has_many :topics, inverse_of: :board

  serialize :config

  acts_as_cached(version:1, expires_in:1.day)

  def to_param
    seo_name
  end
end
