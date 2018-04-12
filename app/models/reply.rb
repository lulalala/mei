# frozen_string_literal: true

class Reply < ApplicationRecord # :nodoc:
  belongs_to :ancestor, class_name: 'Post', optional: true
  belongs_to :descendant, class_name: 'Post', optional: true
end
