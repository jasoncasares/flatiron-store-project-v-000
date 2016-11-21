class Cart < ActiveRecord::Base

  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user

  def add_item(item_id)
    item = Item.find(item_id)
    if self.items.include?(item)
      line_item = LineItem.where(item_id: item_id, cart_id: self.id)[0]
      line_item.quantity += 1
      line_item.save
    else
      line_item = LineItem.new(item_id: item_id, cart_id: self.id)
    end
    line_item
  end

  def total
    cart_total = 0
    items.each do |item|
      cart_total += item.price
    end
    cart_total
  end

  def update_inventory_after_checkout
    line_items.each do |li|
      li.item.inventory -= li.quantity
      li.item.save
    end
    self.line_items = []
    self.status = "submitted"
    save
  end


end
