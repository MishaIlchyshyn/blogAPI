class Post < ApplicationRecord
  validates :title, :body, presence: true
  validates :title, length: { maximum: 100 }
  belongs_to :user
  has_many :comments, dependent: :destroy
end
