class SearchesController < ApplicationController

  def genre_search
    @genre_id = params[:genre_id]
    @items = Item.where(genre_id: @genre_id)
# ビュー（ジャンル検索部分）から、送られてきたgenre_idを @genre_idに代入する。
# @items = Item.where(genre_id: @genre_id) ビュー（ジャンル検索部分）から送られてきたgenre_id`を持つ Itemを全て取得。
  end

end
