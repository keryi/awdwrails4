class StoreController < ApplicationController
  before_action :view_count, only: [:index]

  def index
    @products = Product.order :title
  end

  private

  def view_count
    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end
  end
end
