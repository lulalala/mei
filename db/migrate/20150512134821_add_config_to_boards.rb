class AddConfigToBoards < ActiveRecord::Migration[5.1]
  def change
    add_column :boards, :config, :text, comment: 'board-specific configuration in YAML'
  end
end
