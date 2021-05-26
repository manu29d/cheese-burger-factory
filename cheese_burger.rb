require_relative './patty_types'

class CheeseBurger

  INITIAL_STATE = 'new_burger'.freeze
  FAILED_STATE = 'failed'.freeze

  attr_accessor :state, :options, :inventory

  def initialize(burger_factory, options: {})
    @options = options
    @state = INITIAL_STATE
    @inventory = burger_factory.inventory
  end

  def make!
    @state = 'gathering_ingredients'
    begin
      gather_buns
      gather_patty
      @state = 'gathered_ingredients'
    rescue
      @state = FAILED_STATE
    end
    tower_burger if @state == 'gathered_ingredients'
    raise 'Failed to make burger' if @state == FAILED_STATE
  end

  def serve!
    @state = 'served' if @state == 'burger_built'
    self
  end

  private

  def gather_buns
    @state = 'gathering_buns'
    @inventory.supply_buns
  end

  def gather_patty
    @state = 'gathering_patty'
    @inventory.supply_patty(@options[:patty])
  end

  def tower_burger
    @state = 'burger_built'
  end
end
