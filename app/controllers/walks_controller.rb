class WalksController < ApplicationController
  def index
    @walks = current_user.walks.all
  end

  def new
    @walk = Walk.new
  end

  def create
    @walk = Walk.new(walk_params)
    if @walk.save
      if current_user
        @walk.update(user_id: current_user.id)
      end
      process_and_create_start_location_and_walk_locations
      redirect_to walk_path(@walk)
    else
      render :new
    end
  end

  def show
    if current_user
      @walk = current_user.walks.find(params[:id])
    else
      @walk = Walk.find(params[:id])
    end
  end

  private

  def walk_params
    params.require(:walk).permit(:name, :distance)
  end

  def process_position(position_type)
    position_type = params[:walk][position_type.to_sym]
    processed_position = position_type.split(",")
    lng_lat = processed_position[0..1]
    @lat = lng_lat[0]
    @lng = lng_lat[1]
  end

  def lookup_location
    @lat_lng = cookies[:lat_lng].split("|")
  end

  def process_ip(ip_location)
    @lat = @lat_lng[0]
    @lng = @lat_lng[1]
  end

  def create_start_location(type)
    instance_variable_set("@#{type}_location",Kernel.const_get("#{type.capitalize}Location").create(latitude: @lat, longitude: @lng, walk_id: @walk.id))
  end

  def process_and_create_start_location_and_walk_locations
    types = ["start_location", "finish_location"]
    types.each_with_index do |type, i|
      if process_position(type) == nil
        process_ip(lookup_location)
      end
      location_type = type.partition("_")[0]
      create_start_location(location_type)
    end
    @walk.assign_locations
  end
end
