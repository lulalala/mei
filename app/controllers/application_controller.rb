# frozen_string_literal: true

class ApplicationController < ActionController::Base # :nodoc:
  protect_from_forgery with: :exception

  def index
    render layout: false
  end

  before_action :set_board
  def set_board
    unless params[:board].blank?
      @board = Board.find_by(seo_name: params[:board])
      default_url_options[:board] = params[:board]
    end
  end

  before_action :set_boards
  def set_boards
    @boards = Board.all
  end

  after_action :prepare_unobtrusive_flash
end
