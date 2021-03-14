class Comment < ApplicationRecord
  validates :body, presence: true
  validates :body, length: { maximum: 1000 }
  belongs_to :user
  belongs_to :post
end
