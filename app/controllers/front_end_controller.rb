class FrontEndController < ApplicationController
  def index
    @stored_products = StoredProduct.all
    render json: @stored_products
  end
end
