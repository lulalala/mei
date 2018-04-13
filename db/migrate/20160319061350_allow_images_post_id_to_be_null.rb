class AllowImagesPostIdToBeNull < ActiveRecord::Migration[4.2]
  def change
    change_column_null :images, :post_id, true
  end
end
