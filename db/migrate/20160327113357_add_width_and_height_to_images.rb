# frozen_string_literal: true

class AddWidthAndHeightToImages < ActiveRecord::Migration[5.1]
  def change
    change_table :images do |t|
      t.integer :width, after: :image
      t.integer :height, after: :width
      t.integer :thumb_width, after: :height
      t.integer :thumb_height, after: :thumb_width
    end
  end
end
