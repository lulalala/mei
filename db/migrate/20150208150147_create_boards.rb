class CreateBoards < ActiveRecord::Migration[5.1]
  def change
    create_table :boards, comment: 'board' do |t|
      t.string :seo_name, null: false, comment: 'represent name in URL. Must be URL valid characters.'
      t.string :name, null: false, comment: 'display name on top of page'

      t.timestamps null: false
    end
    add_index :boards, :seo_name, unique: true
  end
end
