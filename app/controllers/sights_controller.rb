class SightsController < ApplicationController
  def index
    @sights = Sight.all
  end
end
