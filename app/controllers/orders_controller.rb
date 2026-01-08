class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @confirmed_orders = current_user.orders.where(status: 'Confirmado').order(created_at: :desc)
    @cancelled_orders = current_user.orders.where(status: 'Cancelado').order(created_at: :desc)
  end

  def create
    @order = current_user.orders.build

    if params[:direct_buy] && params[:product_id]
      # Lógica para "Comprar Agora"
      product = Product.find(params[:product_id])
      @order.total_price = product.price
      @order.order_items.build(product: product, quantity: 1, price: product.price)
    else
      # Lógica normal do carrinho
      @order.total_price = current_cart.total_price
      current_cart.cart_items.each do |item|
        @order.order_items.build(product: item.product, quantity: item.quantity, price: item.product.price)
      end
    end

    if @order.save
      current_cart.cart_items.destroy_all unless params[:direct_buy]
      redirect_to orders_path, notice: "Pedido realizado com sucesso!"
    else
      redirect_to cart_path, alert: "Erro ao processar pedido."
    end
  end

  def destroy
    @order = current_user.orders.find(params[:id])
    @order.update(status: 'Cancelado')
    redirect_to orders_path, notice: "Pedido cancelado."
  end
end
