# frozen_string_literal: true

require_relative 'validate'
require_relative 'wagon'

class CargoWagon < Wagon
  include Validation
  attr_reader :volume, :free_volume, :occupied_volume
  
  validate :volume, :type, Integer 

  private

  attr_writer :volume, :free_volume, :occupied_volume

  public

  def initialize(wagon_type = :cargo, volume)
    super(wagon_type)
    @volume = volume
    @occupied_volume = 0
    @free_volume = volume
    validate!
  end

  def take_volume(wagon_volume)
    self.occupied_volume += wagon_volume
    self.free_volume = volume - occupied_volume
  end

  private

end
