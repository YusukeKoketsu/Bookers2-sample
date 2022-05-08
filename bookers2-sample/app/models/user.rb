class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # モデルの関連付け
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # フォロー・フォロワー機能のリレーション
  # フォローしている
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォロされている
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # フォローしている人の一覧
  has_many :follower_user, through: :follwed, source: :follower
  # フォローされている人の一覧（フォロワー）
  has_many :following_user, through: :follower, source: :followed

  # ActiveStorageでプロフィール画像を保存できるように設定
  has_one_attached :profile_image

  # 名前を２～２０文字に制限とuniqueness: trueで一意性を持たせる
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  # 自己紹介文を最大で５０文字までの制限
  validates :introduction, length: {maximum: 50}



  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  # followeメソッド＝フォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # unfollweメソッド＝フォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # followingメソッド＝現在自分がフォローしているユーザーの確認
  def following?(user)
    following_user.include?(user)
  end

end
