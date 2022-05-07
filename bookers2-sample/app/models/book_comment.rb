class BookComment < ApplicationRecord
  # モデルの関連付け
  belongs_to :user
  belongs_to :book

  # コメントが空で投稿できないようにする
 validates :comment, presence: true
end
