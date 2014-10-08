class UserController < ApplicationController
   def user_params
    params.require(:user).permit(:provider, :uid, :name)
  end
end
