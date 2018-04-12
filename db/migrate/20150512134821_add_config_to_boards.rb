# frozen_string_literal: true

class AddConfigToBoards < ActiveRecord::Migration[5.1] # :nodoc:
  def change
    add_column :boards, :config, :text, comment: 'board-specific configuration in YAML'
  end
end
