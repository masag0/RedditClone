class PostSub < ApplicationRecord
  validates :post_id, uniqueness: { scope: :sub_id, message: "Already posted under sub" }

  belongs_to :sub

  belongs_to :post
end
