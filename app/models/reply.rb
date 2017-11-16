class Reply < ApplicationRecord
  belongs_to :ancestor, class_name:'Post'
  belongs_to :descendant, class_name:'Post'
end
