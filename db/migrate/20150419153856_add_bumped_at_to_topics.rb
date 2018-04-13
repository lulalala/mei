# frozen_string_literal: true

class AddBumpedAtToTopics < ActiveRecord::Migration[5.1] # :nodoc:
  def change
    add_column :topics, :bumped_at, :datetime, comment: 'topic bump time'
  end
end
