# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_170_523_114_957) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'boards', comment: 'board', force: :cascade do |t|
    t.string 'seo_name', null: false, comment: 'represent name in URL. Must be URL valid characters.'
    t.string 'name', null: false, comment: 'display name on top of page'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.text 'config', comment: 'board-specific configuration in YAML'
    t.index ['seo_name'], name: 'index_boards_on_seo_name', unique: true
  end

  create_table 'images', comment: 'image', force: :cascade do |t|
    t.bigint 'post_id'
    t.string 'image', comment: 'filename'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'remote_url', comment: 'url of image fetched from'
    t.integer 'width'
    t.integer 'height'
    t.integer 'thumb_width'
    t.integer 'thumb_height'
    t.index ['post_id'], name: 'index_images_on_post_id'
    t.index ['remote_url'], name: 'index_images_on_remote_url'
  end

  create_table 'posts', comment: 'text content posted. New post or reply comments are all posts.', force: :cascade do |t|
    t.text 'content', comment: 'text content'
    t.string 'author', comment: 'author name'
    t.string 'email', comment: 'email'
    t.bigint 'topic_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.text 'content_html', comment: 'text content processed into html'
    t.integer 'pos', limit: 2, null: false, comment: 'position of post within topic'
    t.string 'options', comment: 'array of options like sage'
    t.string 'options_raw', comment: 'user input for email and options'
    t.index %w[topic_id pos], name: 'index_posts_on_topic_id_and_pos', unique: true
    t.index ['topic_id'], name: 'index_posts_on_topic_id'
  end

  create_table 'replies', comment: 'replying relations between posts', force: :cascade do |t|
    t.integer 'ancestor_id', comment: 'post that is being replied to'
    t.integer 'descendant_id', comment: 'post that is the reply'
  end

  create_table 'topics', comment: 'topic of discussion, also called thread', force: :cascade do |t|
    t.string 'title', comment: 'title'
    t.bigint 'board_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'bumped_at', comment: 'topic bump time'
    t.integer 'max_pos', limit: 2, default: 0, null: false, comment: 'current newest post pos, increment as posts are created'
    t.boolean 'locked', default: false, null: false, comment: 'prevent further replies'
    t.boolean 'file_attachable', default: true, null: false
    t.index ['board_id'], name: 'index_topics_on_board_id'
  end

  create_table 'view_fragments', comment: 'Custom HTML fragments to be displayed', force: :cascade do |t|
    t.bigint 'board_id'
    t.string 'name', null: false, comment: 'name for referencing'
    t.text 'content', comment: 'html fragment'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[board_id name], name: 'index_view_fragments_on_board_id_and_name', unique: true
    t.index ['board_id'], name: 'index_view_fragments_on_board_id'
  end

  add_foreign_key 'images', 'posts'
  add_foreign_key 'posts', 'topics'
  add_foreign_key 'topics', 'boards'
  add_foreign_key 'view_fragments', 'boards'
end
