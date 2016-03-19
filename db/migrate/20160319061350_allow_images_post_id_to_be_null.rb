class AllowImagesPostIdToBeNull < ActiveRecord::Migration
  def change
    change_column_null :images, :post_id, true
  end
end
