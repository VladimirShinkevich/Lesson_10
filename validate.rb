# frozen_string_literal: true

module Validation
  def self.include(base)
    base.extend ClassMethod
    base.include InstanceMethod
  end

  module ClassMethod
    def valid_list
      @valid_list ||= 0
    end

    def validate(atr_name, validation_type, option = nil)
      @valid_list << [atr_name, validation_type, option]
    end
  end

  module InstanceMethod
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def execute_validation(atr_name, validation_type, option = nil)
      atr_value = instance_variable_get("@#{atr_name}")
      send "validate_#{validation_type}", atr_name, option
    end

    def validate_presence(atr_value, option)
      raise StandardError, 'Атрибут не может быть пустой строкой или nil!' if atr_value.nil? || atr_value.to_s.empty?
    end

    def validate_format(atr_value, option)
      raise StandardError, 'Атрибут не соответствует заданному регулярному выражению!' if atr_value.to_s !~ option
    end

    def validate_type(atr_value, option)
      raise StandardError, 'Класс атрибута не совпадает с заданным классом!' if atr_value.class != option
    end

    def validate!
      self.class.valid_list.each { |value| execute_validation(*value)}
    end

  end


end
