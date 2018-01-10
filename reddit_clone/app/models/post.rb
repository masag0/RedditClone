class Post < ApplicationRecord
  validates :title, presence: true
  belongs_to :author, primary_key: :id, foreign_key: :author_id, class_name: :User

  has_many :post_subs, dependent: :destroy, inverse_of: :post
  has_many :subs, through: :post_subs
  has_many :comments

  def comments_by_parent_id
    result = Hash.new{ |k, v| k[v] = [] }

    self.comments.each do |comment|
      result[comment.parent_comment_id] << comment
    end

    result
  end
end
