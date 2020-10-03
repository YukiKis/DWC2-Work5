class Book < ApplicationRecord
	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	def favorited_by?(user)
		Favorite.where(user_id: user, book_id: self.id).exists?
	end

	def self.searched_by_user_whole(search)
		Book.joins(:user).where("users.name LIKE ?",  "#{search}")
	end

	def self.searched_by_user_part(search)
		Book.joins(:user).where("users.name LIKE ?", "%#{search}%")
	end

	def self.searched_by_user_head_part(search)
		Book.joins(:user).where("users.name LIKE ?", "#{search}%")
	end

	def self.searched_by_user_tail_part(search)
		Book.joins(:user).where("users.name LIKE ?", "%#{search}")
	end

	def self.searched_by_book_whole(search)
		Book.where("title LIKE ?", "#{search}")
	end

	def self.searched_by_book_part(search)
		Book.where("title LIKE ?", "%#{search}%")
	end

	def self.searched_by_book_head_part(search)
		Book.where("title LIKE ?", "#{search}%")
	end

	def self.searched_by_book_tail_part(search)
		Book.where("title LIKE ?", "%#{search}")
	end
end
