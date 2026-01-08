class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.new
    # Se vier um product_id, o total é apenas desse produto. Senão, é o total do carrinho.
    if params[:product_id]
      @product = Product.find(params[:product_id])
      @total = @product.price
    else
      @total = calculate_cart_total
    end
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.status = "Confirmado"

    # Verifica se é uma compra direta de um produto específico
    if params[:product_id].present?
      product = Product.find(params[:product_id])
      @order.total_price = product.price
      if @order.save
        @order.order_items.create!(product: product, quantity: 1, price: product.price)
        render :success
      else
        @total = product.price
        render :new, status: :unprocessable_entity
      end
    else
      # Fluxo normal do carrinho
      @order.total_price = calculate_cart_total
      if @order.save
        process_cart_items(@order)
        session[:cart] = {}
        render :success
      else
        @total = calculate_cart_total
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:street, :city, :state, :zip_code)
  end

  def calculate_cart_total
    total = 0
    return total if session[:cart].blank?
    session[:cart].each do |pid, q|
      product = Product.find_by(id: pid)
      total += product.price * q if product
    end
    total
  end

  def process_cart_items(order)
    session[:cart].each do |pid, q|
      product = Product.find_by(id: pid)
      order.order_items.create!(product: product, quantity: q, price: product.price) if product
    end
  end
end
