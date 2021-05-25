class PattyTypes
  DEFAULT = 'regular'.freeze
  PREMIUM = 'premium'.freeze
  VEGGIE = 'veggie'.freeze

  def self.all
    [DEFAULT, PREMIUM, VEGGIE]
  end
end
