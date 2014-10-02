class WalksController < ApplicationController
  def new
    @walk = Walk.new
  end

  def create
    @walk = Walk.new(walk_params)
    if @walk.save
      redirect_to walk_path(@walk)
    else
      flash[:error] = "Distance field cannot be blank"
      render :new
    end
  end

  def show
  end

  private
  def walk_params
    params.require(:walk).permit(:name, :distance)
  end
end
