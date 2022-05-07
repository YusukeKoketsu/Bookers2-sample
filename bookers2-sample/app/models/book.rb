class Book < ApplicationRecord
  # モデルの関連付け
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # タイトルが空でないように、本文が空でないようにと、最大で２００文字までの制限
  validates :title, presence:true
  validates :body ,presence:true,length:{maximum:200}


  # ユーザidがFavoritesテーブル内に存在（exists?）するかどうか 存在していればtrue、存在していなければfalse
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
