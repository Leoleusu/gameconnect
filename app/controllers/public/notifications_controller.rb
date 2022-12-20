class Public::NotificationsController < ApplicationController
  
  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(20)
    @notifications.where(is_check: false).each do |notification|
      notification.update_attributes(is_check: true)
    end
  end
end
