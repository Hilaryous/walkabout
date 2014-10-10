class StaticPagesController < ApplicationController
  def home
    @sights = Sight.all
    @hash = Gmaps4rails.build_markers(@sights) do |sight, marker|
      marker.lat sight.location.latitude
      marker.lng sight.location.longitude
      marker.picture({
        "url" => "http://www.portland5.com/sites/default/files/venue/marker_green.png",
        "width" => 27,
        "height" => 40
        })
    end
  end
end
