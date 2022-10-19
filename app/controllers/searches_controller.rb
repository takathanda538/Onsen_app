class SearchesController < ApplicationController
  # before_action :authenticate_user!

  def search
    @range = params[:range]

    if @range == "顧客"
      @customers = Customer.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word])
    end
  end
end
