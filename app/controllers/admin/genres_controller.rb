class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    genre = Genre.new(genre_params)
    if genre.save
      flash[:notice] = "登録されました"
      redirect_to admin_genres_path
    else
      flash[:notice] = "登録失敗ました"
      @genres = Genre.all
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "編集されました"
      redirect_to admin_genres_path
    else
      flash[:notice] = "編集失敗ました"
      render :edit
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end
end
