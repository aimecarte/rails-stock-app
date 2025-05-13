class Admin::UsersController < Admin::BaseController 
  before_action :authenticate_admin!
  before_action :set_user, only: [:edit, :update, :show]

  def new
    @user = User.new
  end

  def edit; end

  def show;  end
  
  def update
    if @user.update(user_params)
      if @user.isApproved?
        UserMailer.account_approve(@user).deliver_now
        redirect_to admin_index_path, notice: "User details updated successfully."
      else
        redirect_to admin_index_path, notice: "User details updated successfully."
      end
    else
      render :edit, alert: "Error Updating user details." 
    end
  end
 
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_index_path, notice: "User created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def authenticate_admin!
    unless current_user&.isAdmin?
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :isAdmin, :isApproved)
  end

end