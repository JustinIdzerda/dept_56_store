class Product < ActiveRecord::Base
	has_many :line_items
  
  before_destroy :ensure_not_referenced_by_any_line_item

	validates :item_number, :name, presence: true
	validates :price, numericality: { greater_than_or_equal_to: 0.01 }

private
	 # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item 
  	if line_items.empty?
      return true 
    else
      errors.add(:base, 'Line Items present')
      return false 
    end
  end
end
