class Admin::BaseController < ApplicationController
  before_action :authenticate_user!  # Ensure user is logged in
  before_action :ensure_admin!  # Custom method to ensure only admins can access

  private

  def ensure_admin!
    redirect_to root_path, alert: "You must be an admin to access this page" unless current_user.isAdmin?
  end
end
