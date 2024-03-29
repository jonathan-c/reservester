class RestaurantsController < ApplicationController
  before_filter :authenticate_owner!, except: [:index, :show]
  before_filter :check_if_owner, only: [:edit, :update, :destroy]
  
  def index
    @restaurants = Restaurant.all
    @categories = Category.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = current_owner.restaurants.new
  end

  def create
    @restaurant = current_owner.restaurants.build(params[:restaurant])
    if @restaurant.save
      redirect_to restaurants_path
    else
      flash[:error] = display_errors(@restaurant)
      render new_restaurant_path
    end
  end

  def edit
    @restaurant = current_owner.restaurants.find(params[:id])
  end

  def update
    @restaurant = current_owner.restaurants.find(params[:id])
    @restaurant.update_attributes(params[:restaurant])
    if @restaurant.errors.any?
      flash[:error] = display_errors(@restaurant)
      redirect_to edit_restaurant_path(@restaurant)
    else
      redirect_to restaurant_path(@restaurant)
    end
  end

  def destroy
    @restaurant = current_owner.restaurants.find(params[:id])
    @restaurant.destroy
    redirect_to restaurants_path
  end
  
  private
  
    def check_if_owner
      if current_owner.has_ownership?(Restaurant.find(params[:id]))
        return
      else
        flash[:error]= "You do not have permission to do that." 
        redirect_to :back
      end
    end
    
    def display_errors(restaurant)
      "<ul>" + restaurant.errors.full_messages.map{|o| "<li>" + o + "</li>" }.join("") + "</ul>"
    end

end
