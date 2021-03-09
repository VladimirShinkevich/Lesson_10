module Accessor
  def attr_accessor_with_history(*names)
    names.each do |name|
      raise TypeError, 'Название должно быть символом' unless names.is_a?(Symbol)

      create_getter(name)
      create_setter_with_history(name)
      create_getter("#{name}_history")
    end
  end

  def strong_attr_accessor(var, type)
    create_getter(var)
    create_strong_setter(var, type)
  end

  private

  def create_getter(var)
    define_method(var) do
      instance_variable_get("@#{var}".to_sym)
    end
  end

  def create_setter_with_history(var)
    define_method("@#{var}=".to_sym) do |value|
      instance_variable_set("@#{var}", value)
      instance_variable_set("@#{var}_history", []) if instance_variable_get("#{var}_history").nil?
      instance_variable_get("@#{var}_history").push(value)
    end
  end

  def create_strong_setter(var, type)
    define_method("@#{var}=".to_sym) do |value|
      raise TypeError if value.class != (type)
      instance_variable_set("@#{var}", value)
    end
  end

end
