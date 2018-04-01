class AllowImagesPostIdToBeNull < ActiveRecord::Migration[5.1]
  def change
    change_column_null :images, :post_id, true
  end
end
