class UsersController < ApplicationController
  def index
    users = Cbe::User.all
    render json: to_jsonld(users, users_path, "User")
  end

  def show
    user = Cbe::User.find(params[:id])
    if params.include?('pubkey')
      render text: user.pubkey
    else
      render json: to_jsonld(user, user_path, 'User')
    end
  end
end