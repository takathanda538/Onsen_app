class Public::NotificationsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @notifications = current_customer.passive_notifications.page(params[:page]).per(20)
  end
  
  def destroy
    @notifications = current_customer.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
