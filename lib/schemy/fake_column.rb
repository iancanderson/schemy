class FakeColumn
  attr_reader :name

  def initialize(name, type)
    @name = name
    @type = type
  end
  def to_s
    "#{@name}:#{@type}"
  end
end
