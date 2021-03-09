# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validate'
require_relative 'accessor'

class Station
  include InstanceCounter
  include Validation
  include Accessor
  attr_reader :trains, :station_name

  @@stations = []

  class << self
    attr_accessor :stations
  end

  def self.all
    @@stations
  end

  validate :station_name, :presence
  validate :station_name, :format
  validate :station_name, :type, String

  def initialize(station_name)
    @station_name = station_name
    @trains = []
    @@stations << self
    register_instance
    validate!
  end

  def train_arrived(train)
    @trains << train
  end

  def train_send(train)
    @trains.delete(train)
  end

  def show_cargo_trains
    @trains.select { |train| train.train_type == :cargo }
  end

  def show_passenger_trains
    @trains.select { |train| train.train_type == :passenger }
  end

  def across_train_on_station(&block)
    trains.each_with_index(&block) if block_given?
  end
end
