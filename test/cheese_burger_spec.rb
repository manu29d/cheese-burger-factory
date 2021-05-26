require 'minitest/autorun'
require_relative '../cheese_burger'
require_relative '../patty_types'

describe CheeseBurger do

  let(:burger_factory_mock) { Minitest::Mock.new }
  let(:inventory_mock) { Minitest::Mock.new }

  subject { CheeseBurger.new(burger_factory_mock) }

  before do
    burger_factory_mock.expect :inventory, inventory_mock
  end

  describe 'new CheeseBurger object' do
    it { subject.must_respond_to :state }
    it { subject.must_respond_to :inventory }
    it { subject.must_respond_to :options }
  end

  describe 'making a burger' do
    it 'should be in state burger_built when successful' do
      subject.inventory.expect :supply_buns, nil
      subject.inventory.expect :supply_patty, nil, [PattyTypes::DEFAULT]

      subject.make!

      subject.state.must_equal 'burger_built'
    end

    it 'should raise an error if gathering buns fails' do
      subject.inventory.expect :supply_buns, -> { raise RuntimeError }

      making_a_burger = -> { subject.make! }

      making_a_burger.must_raise RuntimeError, 'Failed to make burger'
      subject.state.must_equal 'failed'
    end

    it 'should raise an error if gathering patty fails' do
      subject.inventory.expect :supply_buns, nil
      subject.inventory.expect :supply_patty, -> { raise RuntimeError }

      making_a_burger = -> { subject.make! }

      making_a_burger.must_raise RuntimeError, 'Failed to make burger'
      subject.state.must_equal 'failed'
    end
  end

  describe '#serve!' do

    describe 'when the burger is built' do
      it 'should update burger state to served' do
        subject.state = 'burger_built'

        subject.serve!

        subject.state.must_equal 'served'
      end
    end

    describe 'when burger is not build' do
      it 'should not update burger state to served' do
        subject.serve!

        subject.state.must_equal 'new_burger'
      end
    end
  end
end
