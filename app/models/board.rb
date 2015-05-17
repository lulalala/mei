class Board < ActiveRecord::Base
  has_many :topics, inverse_of: :board

  serialize :config

  def to_param
    seo_name
  end
end
