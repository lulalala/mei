class Board < ActiveRecord::Base
  has_many :topics, inverse_of: :board

  serialize :config, BoardConfigSerializer
  def config
    @cascaded_config ||= AppConfig.board.dup.tap do |c|
      if board_config = super
        c.merge!(board_config)
      end
    end
  end

  def to_param
    seo_name
  end

  # Reply Omittion

  def reply_omit_condition
    AppConfig.board.reply_omit_condition
  end
end
