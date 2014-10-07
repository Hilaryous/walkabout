class StartLocationSerializer < ActiveModel::Serializer
  attributes :street, :city, :state, :zipcode, :countryp
end
