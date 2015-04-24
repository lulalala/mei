module ApplicationHelper
  def render_content(source)
    simple_format source
  end

  def render_view_fragment(name)
    render_cell(:view_fragment, :show, @board, name)
  end

  def render_body_classes
    classes = [ params[:controller].tr('/','_'), params[:action] ]
    classes.join(' ')
  end
end
