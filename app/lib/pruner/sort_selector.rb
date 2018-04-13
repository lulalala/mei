# frozen_string_literal: true

module Pruner
  # Selects topics which should be pruned based on max number and sorting order.
  class SortSelector
    # @param board [Board] board to be pruned from
    # @param max [Integer] maximum number of topics allowed to stay
    # @param sort_column [Symbol] the column to be ordered by, defaults to :id
    # @param sort_direction [Symbol] order direction: :desc or :asc, defaults to :desc
    def initialize(board, max, sort_column: :id, sort_direction: :desc)
      @board = board
      @max = max
      @sort_column = sort_column
      @sort_direction = sort_direction
    end

    # @return [Array<Integer>] ids of Topics which need to be pruned
    def perform
      min = @board.topics.order(@sort_column => @sort_direction).limit(@max).pluck(@sort_column).min
      @board.topics.where("#{@sort_column} < ?", min).pluck(:id)
    end
  end
end
