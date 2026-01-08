require 'rails_helper'

RSpec.describe "Busca de Produtos", type: :system do
  before do
    driven_by(:rack_test)
    @produto1 = Product.create!(name: "iPhone 15", price: 5000, description: "Celular Apple")
    @produto2 = Product.create!(name: "Kindle Paperwhite", price: 800, description: "Leitor de ebook")
  end

  it "encontra um produto pelo nome na barra de busca" do
    visit root_path
    
    fill_in "query", with: "iPhone"
    find("#search-button").click

    expect(page).to have_content("iPhone 15")
    expect(page).not_to have_content("Kindle Paperwhite")
  end
end