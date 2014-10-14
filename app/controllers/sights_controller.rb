class SightsController < ApplicationController
  def index
    @sight_kinds = Sight.sight_kinds
    @sights_by_kind = Sight.sights_by_kind
  end

  def show
    @sight = Sight.find(params[:id])
  end

  def edit
    @sight = Sight.find(params[:id])
  end

  def update
    binding.pry
    @sight = Sight.find(params[:id])
    if @sight.update(sight_params)
      redirect_to sights_path
    else
      render :edit
    end
  end

  private

  def sight_params
    params.require(:sight).permit(:medium)
  end
end
