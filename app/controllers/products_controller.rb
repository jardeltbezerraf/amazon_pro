class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Produto não encontrado."
  end
end
