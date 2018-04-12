# frozen_string_literal: true

class ViewFragmentCell < Cell::Rails
  def show(board, name)
    if view = ViewFragment.where(board: board, name: name).first
      render html: view.content.html_safe
    end
  end
end
