class Product < ApplicationRecord
  has_many :order_items, dependent: :destroy
  
  # Essencial para o Active Storage funcionar
  has_one_attached :image

  validates :name, :price, :description, presence: true
end

