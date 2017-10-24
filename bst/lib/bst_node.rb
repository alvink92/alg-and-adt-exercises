class BSTNode

  attr_accessor :left, :right, :parent, :value
  # attr_reader :value

  def initialize(value)
    @value = value
  end

  def set(inst_var, val)
    self.instance_variable_set(inst_var, val)
  end

  def get(inst_var)
    self.instance_variable_get(inst_var)
  end
end
