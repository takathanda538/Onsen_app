class Public::RelationshipsController < ApplicationController
  
def create
  # binding.pry

  current_customer.follow(params[:customer_id])
   @customer = Customer.find(params[:customer_id])
   @customer.create_notification_follow!(current_customer)
  # redirect＿to request.referer
end

def destroy
  current_customer.unfollow(params[:customer_id])
    @customer = Customer.find(params[:customer_id])
  # redirect_to request.referer
end
  
end
