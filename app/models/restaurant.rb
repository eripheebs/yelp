class Restaurant < ActiveRecord::Base

  validates :name, length: {minimum: 3}, uniqueness: true
  has_many :reviews, dependent: :destroy
  belongs_to :user

  # def build_review(review_params, current_user)
  #   parameters = review_params
  #   parameters[:user_id] = current_user.id
  #   reviews.create(parameters)
  # end
end
