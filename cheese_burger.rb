require_relative './patty_types'

class CheeseBurger

  INITIAL_STATE = 'new_burger'.freeze
  FAILED_STATE = 'failed'.freeze

  attr_accessor :state, :options, :inventory

  def initialize(burger_factory, options = {})
    @options = options
    @state = INITIAL_STATE
    @inventory = burger_factory.inventory
  end

  def make!
    begin
      gather_buns
      gather_patty
      @state = 'gathered_ingredients'
    rescue
      @state = FAILED_STATE
      raise 'Failed to make burger'
    end
    tower_burger
  end

  def serve!
    @state = 'served' if state == 'burger_built'
    self
  end

  private

  def gather_buns
    @state = 'gathering_buns'
    inventory.supply_buns
  end

  def gather_patty
    @state = 'gathering_patty'
    @options[:patty] = @options[:patty] || PattyTypes::DEFAULT
    inventory.supply_patty(@options[:patty])
  end

  def tower_burger
    @state = 'burger_built' if state == 'gathered_ingredients'
  end
end
