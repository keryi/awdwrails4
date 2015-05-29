class PhotosController < ApplicationController
  def index
    @photos = Photo.order :created_at
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new photo_params
    if @photo.save
      redirect_to photos_path, notice: 'A new photo has been added.'
    else
      render :new
    end
  end

  def photo
    @photo = Photo.find params[:id]
    send_data @photo.data, filename: @photo.title, type: @photo.content_type,
      disposition: 'inline'
  end

  def destroy
    @photo = Photo.find params[:id]
    @photo.destroy
    redirect_to photos_path
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :description, :uploaded_file)
  end
end
