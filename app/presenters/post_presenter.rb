# frozen_string_literal: true

class PostPresenter < LulalalaPresenter::Base # :nodoc:
  def dom_id
    "p-#{model.topic_id}-#{model.pos}"
  end
end
