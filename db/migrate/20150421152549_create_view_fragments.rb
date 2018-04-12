class CreateViewFragments < ActiveRecord::Migration[5.1]
  def change
    create_table :view_fragments, comment: 'Custom HTML fragments to be displayed' do |t|
      t.references :board, foreign_key: true
      t.string :name, null: false, comment: 'name for referencing'
      t.text :content, comment: 'html fragment'

      t.timestamps null: false
    end
    add_index :view_fragments, [:board_id, :name], unique: true
  end
end
