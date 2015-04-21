module ApplicationHelper
  def render_content(source)
    simple_format source
  end

  def render_view_fragment(name)
    render_cell(:view_fragment, :show, @board, name)
  end
end
