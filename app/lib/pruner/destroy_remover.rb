# Destroy topic with the provided ids
module Pruner
  class DestroyRemover
    # @param board [Board] board to be pruned from
    # @param topic_ids [Array<Integer>] ids of Topic to remove
    def initialize(board, topic_ids, **options)
      @board = board
      @topic_ids = topic_ids
    end

    def perform
      @board.topics.where(id: @topic_ids).destroy_all
    end
  end
end
