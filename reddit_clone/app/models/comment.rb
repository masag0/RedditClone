class Comment < ApplicationRecord
  validates :content, presence: true

  belongs_to :author, class_name: :User, foreign_key: :author_id, primary_key: :id
  belongs_to :post
  belongs_to :parent_comment,
    optional: true
  has_many :child_comments,
    primary_key: :id,
    foreign_key: :parent_comment_id,
    class_name: :Comment
end
