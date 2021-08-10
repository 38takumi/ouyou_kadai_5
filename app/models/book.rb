class Book < ApplicationRecord
 belongs_to :user
 has_many :book_comments, dependent: :destroy
 has_many :favorites, dependent: :destroy
 
 def favorited_by?(user)
   # いいねを押したuser.idを全て取得、条件に当てはまるかどうか
   favorites.where(user_id: user.id).exists?
   # favorites.exists?(user_id: user.id)
 end
 
 # def favorited_by?(user)
 #   # いいねを押したuser.idを全て取得、条件に当てはまるかどうか
 #   self.favorites.exists?(user_id: user.id)
 # end
 
 # 検索機能　ここから
 def self.search(search, word)
  if search == "forward_match"
   @book = Book.where("title LIKE?","#{word}%")
  elsif search == "backward_match"
    @book = Book.where("title LIKE?","%#{word}")
  elsif search == "perfect_match"
    @book = Book.where("#{word}")
  elsif search == "partial_match"
    @book = Book.where("title LIKE?","%#{word}%")
  else
    @book = Book.all
  end
 end
 # 検索機能　ここまで
 
 
 validates :title, presence: true

 validates :body, presence: true
 validates :body, length: { maximum: 200 }

end