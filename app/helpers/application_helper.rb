# frozen_string_literal: true

module ApplicationHelper
  def render_body_classes
    classes = [params[:controller].tr('/', '_'), params[:action]]
    classes.join(' ')
  end

  # Renders custom HTML content.
  #
  # Order of precedence:
  # in app/views/partials/_global/
  # in app/views/partials/{board seo name}/
  # in view_fragments table in database
  def render_custom_partial(name)
    ["partials/#{@board.seo_name}/#{name}", "partials/_global/#{name}"].each do |path|
      if lookup_context.template_exists?(path, nil, true)
        return render(partial: path)
      end
    end

    render_cell(:view_fragment, :show, @board, name)
  end

  def current_page
    params[:page] || 1
  end
end
