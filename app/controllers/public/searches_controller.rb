class Public::SearchesController < ApplicationController

  def genre_search
    @genre_id = params[:genre_id]
    @items = Item.where(genre_id: @genre_id).page(params[:page]).per(8)
    @genres = Genre.all
    @items_all = Item.where(genre_id: @genre_id).count
# ビュー（ジャンル検索部分）から、送られてきたgenre_idを @genre_idに代入する。
# @items = Item.where(genre_id: @genre_id) ビュー（ジャンル検索部分）から送られてきたgenre_id`を持つ Itemを全て取得。
  end

  def search
    @content = params[:content]
    if @content.blank?
      flash[:notice] = '検索キーワードを入力してください。'
      redirect_to request.referer
    else
      @records = Item.search_for(@content).page(params[:page]).per(8)
      @genres = Genre.all
      @items_all = Item.search_for(@content).count
    end
  end

end
