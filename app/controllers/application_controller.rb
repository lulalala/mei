class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_board
  def set_board
    @board = Board.find_by(seo_name:params[:board])
    default_url_options[:board] = params[:board]
  end

  after_action :prepare_unobtrusive_flash
end
