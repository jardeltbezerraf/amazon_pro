require 'rails_helper'

RSpec.describe "Carrinho de Compras", type: :request do
  let(:product) { Product.create!(name: "Mouse Gamer", price: 100, description: "Mouse RGB") }

  it "adiciona itens ao carrinho e incrementa quantidade" do
    post add_to_cart_path(product)
    post add_to_cart_path(product)
    
    expect(session[:cart][product.id.to_s]).to eq(2)
  end

  it "remove itens do carrinho um por um" do
    # Adiciona 2 unidades
    post add_to_cart_path(product)
    post add_to_cart_path(product)
    
    # Remove 1 unidade
    delete remove_from_cart_path(product)
    expect(session[:cart][product.id.to_s]).to eq(1)

    # Remove a última unidade
    delete remove_from_cart_path(product)
    expect(session[:cart][product.id.to_s]).to be_nil
  end
end