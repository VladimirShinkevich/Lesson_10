# frozen_string_literal: true

require_relative 'company'
require_relative 'validate'

class Wagon
  include Company
  include Validation
  attr_reader :wagon_type

  class << self
    attr_accessor :wagon_type
  end

  def initialize(wagon_type)
    @wagon_type = wagon_type
  end

end
