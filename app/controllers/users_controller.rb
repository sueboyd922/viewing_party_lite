class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    user = User.new(user_params)
      if user.save
        redirect_to "/users/#{user.id}"
      else
        redirect_to "/users/register"
        # require "pry"; binding.pry
        flash[:notice] = user.errors.full_messages
      end
  end

private
  def user_params
    params.permit(:name, :email, :password_confirmation, :password)
  end

end
