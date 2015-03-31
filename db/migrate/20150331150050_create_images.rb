class CreateImages < ActiveRecord::Migration
  def change
    create_table :images, comment:'image' do |t|
      t.references :post, index: true, foreign_key: true
      t.string :image, comment:'filename'

      t.timestamps null: false
    end
  end
end
