# frozen_string_literal: true

# Represents an image board, for example /cat/ for Cat pictures and discussion
class Board < ApplicationRecord
  has_many :topics, inverse_of: :board

  serialize :config, BoardConfigSerializer
  def config
    @cascaded_config ||= Setting.dig_and_wrap(:board).tap do |c|
      if board_config = super
        c.merge(board_config)
      end
    end
  end

  def to_param
    seo_name
  end

  # Reply Omittion

  def reply_omit_condition
    Setting.dig(:board, :reply_omit_condition)
  end

  # @return total file size in bytes
  def file_size
    file_size = 0

    Image.joins(post: :topic).where(post: { topic: { board: self } }).find_each do |i|
      file_size += i.file_size
    end

    file_size
  end
end
