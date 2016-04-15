class Restaurant < ActiveRecord::Base

  validates :name, length: {minimum: 3}, uniqueness: true
  has_many :reviews, dependent: :destroy
  belongs_to :user

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  # def build_review(review_params, current_user)
  #   parameters = review_params
  #   parameters[:user_id] = current_user.id
  #   reviews.create(parameters)
  # end
end
