class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies, comment:'replying relations between posts' do |t|
      t.integer :ancestor_id, comment:'post that is being replied to'
      t.integer :descendant_id, comment:'post that is the reply'
    end
  end
end
