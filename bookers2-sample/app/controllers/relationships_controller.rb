class RelationshipsController < ApplicationController
  # フォローする Userモデルで定義したfollowメソッド
  def create
   current_user.follow(params[:user_id])
  # 遷移前のURLを取得してリダイレクト
   redirect_to request.referer
  end

  # フォローを外す　Userモデルで定義したunfollowメソッド
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  # follower一覧 following_userメソッド ：Userモデルで定義済
  def follower
    user = User.find(params[:user_id])
    @users = user.following_user
  end


  # followed一覧 follower_userメソッド ：Userモデルで定義済  自分に対してフォローしているユーザー
  def followed
    user = User.find(params[:user_id])
    @users = user.follower_user
  end



end
