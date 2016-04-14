class RestaurantsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
    if current_user
      @id = current_user.id
    else
      @id = false
    end
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    current_user.restaurants << @restaurant
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    if !current_user.has_created_restaurant?(@restaurant)
      flash[:notice] = 'That restaurant does not belong to you'
      redirect_to '/restaurants'
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if current_user.has_created_restaurant?(@restaurant)
      @restaurant.update(restaurant_params)
      redirect_to '/restaurants'
    else
      flash[:notice] = 'That restaurant does not belong to you'
      redirect_to '/restaurants'
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if current_user.has_created_restaurant?(@restaurant)
      @restaurant.destroy
      flash[:notice] = 'Restaurant deleted successfully'
      redirect_to '/restaurants'
    else
      flash[:notice] = 'That restaurant does not belong to you'
      redirect_to '/restaurants'
    end
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end

end
