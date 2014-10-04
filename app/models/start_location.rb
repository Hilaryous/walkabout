class StartLocation < Location
  before_create :set_default_to_current_ip

  def set_default_to_current_ip
    #note cannot set default here because the method is on the request can only do in controller... yay!
  end
end
