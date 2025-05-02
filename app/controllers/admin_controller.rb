class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @user = User.all.order(id: :asc)
    @trader = User.where(isAdmin: false).order(id: :asc) #display trader user 

  end

  def show
    @transaction = Transaction.all
  end

  def edit; end

  def new
    @user = User.new
    @transaction = Transaction.all
  end
  

  def create
    @user = User.new(user_params)
      if user.save
        redirect_to admin_path, notice: "Trader created successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end
    
  private 
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :isAdmin, :isApproved)
  end

  def require_admin
    unless current_user&.isAdmin?
      redirect_to root_path, notice: "Access denied."
    end
  end

end
