class AddConfigToBoards < ActiveRecord::Migration[4.2]
  def change
    add_column :boards, :config, :text, comment:'board-specific configuration in YAML'
  end
end
