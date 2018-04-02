# Prunes a board.
# The pruning process is divided into two parts,
# the first part is the selection of topics to delete,
# and the second part is the removal of these topics.
# The strategies for these can be changed in the config file.
#
# Configuration:
#   prune:
#     selector_class: class name of the selector.
#     selector_options: hash of options to pass to the selector
#     remover_class: class name of the remover.
#     remover_options: hash of options to pass to the remover
#   pagination:
#     max_page: maximum number of pages allowed
#     per_page: number of topics to display per page
class PruneJob < ActiveJob::Base
  queue_as :default

  # @param board [Board] the board to prune
  def perform(board)
    config = board.config

    prune = config.dig(:prune)
    return if prune['selector_class'].nil? || prune['remover_class'].nil?

    per_page = config.dig(:pagination, :per_page)
    max_page = config.dig(:pagination, :max_page)

    selector_class = Pruner.const_get(prune[:selector_class])
    remover_class = Pruner.const_get(prune[:remover_class])

    selector_options = (prune[:selector_options] || HashWithIndifferentAccess.new).symbolize_keys
    remover_options = (prune[:remover_options] || HashWithIndifferentAccess.new).symbolize_keys

    ids = selector_class.new(board, per_page * max_page, selector_options).perform
    remover_class.new(board, ids, remover_options).perform
  end
end
