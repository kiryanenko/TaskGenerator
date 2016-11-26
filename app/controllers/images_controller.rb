class ImagesController < ApplicationController
  def index
    @images = current_user.images
  end

  def create
    @image = current_user.images.build image_create_params
    @image.save
    render :create, :layout => 'clear'
  end

  private
  def image_create_params
    params.permit(:upload)
  end
end
