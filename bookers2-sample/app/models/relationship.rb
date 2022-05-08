class Relationship < ApplicationRecord
  # Userモデルを「Follower」と「Followed」に分けるイメージ
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
