class WalkLocation < ActiveRecord::Base
  belongs_to :walk
  belongs_to :location  
end
