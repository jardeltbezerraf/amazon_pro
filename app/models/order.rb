class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  
  before_validation :set_default_status, on: :create
  before_create :generate_tracking_code

  private

  def set_default_status
    self.status ||= 'Confirmado'
  end

  def generate_tracking_code
    self.tracking_code = "AMZ#{rand(100_000_000..999_999_999)}BR"
  end
end
