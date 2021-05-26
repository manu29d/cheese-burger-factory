require 'minitest/autorun'
require_relative '../burger_factory'

class BurgerFactoryTest < Minitest::Test

  def setup
    @new_factory = BurgerFactory.new()
  end

  def test_new_object
    assert_respond_to @new_factory, :inventory
    assert_respond_to @new_factory, :order_count
    assert_equal 'Inventory', @new_factory.inventory.class.to_s
    assert_equal 0, @new_factory.order_count
  end

  def test_order_throws_error_when_inventory_empty
    @new_factory.inventory.stub :is_empty?, true do
      assert_raises(RuntimeError, 'Cannot take order') { @new_factory.order }
    end
  end

  def test_order_returns_burger
    assert_equal 'CheeseBurger', @new_factory.order.class.to_s
  end

  def test_restock_inventory
    @new_factory.order
    assert_equal 19, @new_factory.inventory.buns
    @new_factory.restock_inventory
    assert_equal 20, @new_factory.inventory.buns
  end
end
