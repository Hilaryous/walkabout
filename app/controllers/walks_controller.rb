class WalksController < ApplicationController
  def new
    @walk = Walk.new
  end
end
