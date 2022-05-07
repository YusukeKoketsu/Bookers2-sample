class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # モデルの関連付け
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :profile_image

  # 名前を２～２０文字に制限とuniqueness: trueで一意性を持たせる
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  # 自己紹介文を最大で５０文字までの制限
  validates :introduction, length: {maximum: 50}



  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
