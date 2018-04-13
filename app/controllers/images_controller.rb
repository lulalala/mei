# frozen_string_literal: true

class ImagesController < ApplicationController # :nodoc:
  def create
    images = params[:images].map do |file|
      image = Image.create(image: file)
      { id: image.id }
    end

    respond_to do |format|
      format.json { render json: { images: images } }
    end
  end
end
