class BookCommentsController < ApplicationController
  def create
    # ネストしたURLを作成することでparams[:book_id]でBookのidが取得できる book_idカラムの中にbook.idが入る
    book = Book.find(params[:book_id])
    # comment = PostComment.new(post_comment_params)  comment.user_id = current_user.idを1つにまとめた記述
    # 空のコメントテーブルを取得して、現在ログインしているユーザーのidを取得する
    comment = current_user.book_comments.new(book_comment_params)
    # どのbookに対してのコメントなのかを判別 commentモデルのbook_idはbook.idと決めている
    comment.book_id = book.id
    # コメントを保存
    comment.save
    #現在のページへ戻ってくる（リダイレクト）させる
    redirect_to request.referer

  end

  def destroy
    # URLの最後に/:idが含まれます。コントローラで「params[:id]」と記述することで、このURLに含まれる:idを取得できる
    # コメントのidを取得し、どのbookに対してのコメントかをbook_idで取得して削除する
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    redirect_to request.referer
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
