# frozen_string_literal: true

module CustomPathHelper
  def post_path(post, options = {})
    options[:anchor] = post.presenter.dom_id if post.pos != 1
    topic_path(post.topic, options)
  end

  def post_url(post, options = {})
    options[:anchor] = post.presenter.dom_id if post.pos != 1
    topic_utl(post.topic, options)
  end
end

Rails.application.routes.named_routes.url_helpers_module.send(:include, CustomPathHelper)
