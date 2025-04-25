class AdminController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
      if @user.save
        redirect_to new_admin_path, notice: "User Successfully created!"
      else
        render :new, status: :unprocessable_entity
  end




  private user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
