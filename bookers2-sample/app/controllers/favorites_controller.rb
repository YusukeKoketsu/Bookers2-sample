class FavoritesController < ApplicationController

  def create
    # どのbookに対してかを取得している
    book = Book.find(params[:book_id])
    # favorite.user_id = current_user.id favorite = Favorite.new（book_id: book.id）を1つにまとめた記述
    favorite = current_user.favorites.new(book_id: book.id)
    # いいねした事を保存する
    favorite.save
    # 現在のページへ戻ってくる（リダイレクト）させる
    redirect_to request.referer
  end

  def destroy
    # どのbookに対してかを取得している
    book = Book.find(params[:book_id])
    # favorite.user_id = current_user.id favorite = Favorite.new（book_id: book.id）を1つにまとめた記述
    favorite = current_user.favorites.find_by(book_id: book.id)
    # いいねを削除する
    favorite.destroy
    # 現在のページへ戻ってくる（リダイレクト）させる
    redirect_to request.referer
  end

end
