class SightsController < ApplicationController
  def index
    @sights = Sight.all
    @sight_kinds = Sight.sight_kinds
  end
end
