class Board < ApplicationRecord
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

  # @return total file size in bytes
  def file_size
    file_size = 0

    Image.joins(:post => :topic).where(:post => {:topic => {:board => self}}).find_each do |i|
      file_size += i.file_size
    end

    file_size
  end
end
