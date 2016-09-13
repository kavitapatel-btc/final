class Product < ApplicationRecord
  has_many :line_items
  has_many :orders
  has_many :orders, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
   
  private
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base,'line Item present')
      return false
    end
  end
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greter_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format:{
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  def self.latest
      Product.order(:updated_at).last
    end
end
