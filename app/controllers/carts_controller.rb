class CartsController < ApplicationController
  def show
    @cart_items = []
    @total = 0
    
    if session[:cart].present?
      session[:cart].each do |product_id, quantity|
        product = Product.find_by(id: product_id)
        if product
          @cart_items << { product: product, quantity: quantity }
          @total += product.price * quantity
        end
      end
    end
  end

  def add
    product_id = params[:id].to_s
    session[:cart] ||= {}
    session[:cart][product_id] ||= 0
    session[:cart][product_id] += 1
    
    redirect_to cart_path, notice: "Produto adicionado ao carrinho."
  end

  def remove
    product_id = params[:id].to_s
    
    if session[:cart].present? && session[:cart][product_id].present?
      if session[:cart][product_id] > 1
        # Se tem mais de 1, diminui a quantidade
        session[:cart][product_id] -= 1
      else
        # Se tem apenas 1, remove a chave do produto totalmente
        session[:cart].delete(product_id)
      end
    end

    redirect_to cart_path, notice: "Quantidade atualizada no carrinho."
  end
end
