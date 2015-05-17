class AddConfigToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :config, :text, comment:'board-specific configuration in YAML'
  end
end
