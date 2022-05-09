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


  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%'+content)
    else
      Book.where('title LIKE ?', '%'+content+'%')
    end
  end

end
