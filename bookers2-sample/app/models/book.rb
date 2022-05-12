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

# selfは自己、この場合はBook　SearchesControllerのBook.search_for
  def self.search_for(content, method)
    # 検索バーの記述　"完全一致"=>"perfect","前方一致"=>"forward","後方一致"=>"backward","部分一致"=>"partial"
    if method == 'perfect'
      # 完全一致
      Book.where(title: content)
    elsif method == 'forward'
      # 前方一致　content+'%'
      Book.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      # 後方一致　'%'+content
      Book.where('title LIKE ?', '%'+content)
    else
      # 部分一致　'%'+content+'%'
      Book.where('title LIKE ?', '%'+content+'%')
    end
  end

end
