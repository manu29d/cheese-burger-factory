require_relative './cheese_burger'
require_relative './inventory'

class BurgerFactory
  attr_accessor :inventory, :order_count

  def initialize(options = {})
    @inventory = Inventory.new(options)
    @order_count = 0
  end
  
  def order(patty = nil)
    raise 'Cannot take order' if inventory.is_empty?
    burger = CheeseBurger.new(self, { patty: patty })
    @order_count += 1
    process_order(burger)
  end

  def restock_inventory
    inventory.restock!
  end

  private

  def process_order(burger)
    burger.make!
    burger.serve!
  end
end
