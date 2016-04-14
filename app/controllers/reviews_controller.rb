class ReviewsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
    if current_user.has_reviewed? @restaurant
      flash[:notice] = 'You cannot review a restaurant more than once'
      redirect_to restaurants_path
    end
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant.reviews.create(review_params)
    redirect_to restaurants_path
  end

  def review_params
    parameters = params.require(:review).permit(:thoughts, :rating)
    parameters[:user_id] = current_user.id
    parameters
  end
end
