require_relative './patty_types'

class Inventory
  INITIAL_COUNT = 20.freeze


  attr_accessor :options, :buns, :patties

  def initialize(options = {})
    @options = options
    set_initial_count
  end

  def supply_buns
    if buns > 0
      @buns = buns - 1
    else
      raise 'No buns in the inventory'
    end
  end

  def supply_patty(patty_type)
    patty = patties[:patty_type.to_sym]
    if patty > 0
      @patty = patty - 1
    else
      raise 'This patty is not available'
    end
  end

  def restock!
    set_initial_count
  end

  def inventory_empty?
    total_inventory = buns + patties.values.sum
    total_inventory == 0
  end

  private

  def set_initial_count
    @buns = INITIAL_COUNT
    @patties = PattyTypes.all.map { |patty_type| [patty_type.to_sym, INITIAL_COUNT] }.to_h
  end
end
