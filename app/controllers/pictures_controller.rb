class PicturesController < ApplicationController

  def index
    @pictures = Picture.all
  end

  def show
    @picture = Picture.find(params[:id])
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    if @picture.save
      PictureMailer.picture_mail(@picture).deliver
      redirect_to pictures_path, notice: '投稿しました！'
    else
      render :new
    end
  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: '投稿を更新しました！'
    else
      render :edit
    end
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
      flash.now[:danger] = 'Error! Please put a picture.' if @picture.invalid?
  end

  def destroy
    @picture = Picture.find(params[:id])
    if @picture.destroy
      redirect_to pictures_path, notice: '投稿を削除しました！'
    else
      render :index
    end
  end

  private

  def picture_params
    params.require(:picture).permit(:image, :image_cache, :content)
  end
end
