class FinishLocation < Location
  before_create :set_default_to_current_ip

  def set_default_to_current_ip
  end
end
