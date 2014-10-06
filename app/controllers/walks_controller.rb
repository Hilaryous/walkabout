class WalksController < ApplicationController
  def new
    @walk = Walk.new
  end

  def create
    @walk = Walk.new(walk_params)
    if @walk.save
      process_and_create_start_location
      assign_common_locations_to_walk
      redirect_to walk_path(@walk)
    else
      render :new
    end
  end

  def show
    @walk = Walk.find(params[:id])
  end

  private
    def walk_params
      params.require(:walk).permit(:name, :distance)
    end

    def process_position(position)
      position = params[:walk][position.to_sym]
      processed_position = position.split(",")
      lng_lat = processed_position[0..1]
      @lat = lng_lat[0]
      @lng = lng_lat[1]
    end

    def lookup_ip_location
      if Rails.env.development? || Rails.env.test?
        Geocoder.search(request.remote_ip).first
      else
        request.location
      end
    end

    def process_ip(ip_location)
      @lat = lookup_ip_location.latitude
      @lng = lookup_ip_location.longitude
    end

    def process_and_create_start_location
      types = ["start_location"]
      types.each_with_index do |type, i|
        if process_position(type) == nil
          process_ip(lookup_ip_location)
        end
        location_type = type.partition("_")[0]
        create_start_and_end_location(location_type)
      end
    end

    def create_start_and_end_location(type)
      instance_variable_set("@#{type}_location",Kernel.const_get("#{type.capitalize}Location").create(latitude: @lat, longitude: @lng, walk_id: @walk.id))
    end

    def assign_common_locations_to_walk
      (@start_location.nearest_locations.sample(1)).map do |i|
        if i.class == Location
          WalkLocation.create(walk_id: @walk.id, location_id: i.id)
        end
      end
    end
end
