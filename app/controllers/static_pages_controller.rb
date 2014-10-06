class StaticPagesController < ApplicationController
  def home
    @sights = Sight.all
    @hash = Gmaps4rails.build_markers(@sights) do |sight, marker|
      marker.lat sight.location.latitude
      marker.lng sight.location.longitude
    end
  end
end
