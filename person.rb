class Person
  # getter and accessor methods
  attr_reader :id
  attr_accessor :name, :age

  # constructor method
  def initialize(age, name = 'unknown', parent_permission: true)
    @id = Random.rand(1..10_000)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  # public method
  def can_use_services?
    of_age? || parent_permission
  end

  private

  def of_age?
    @age >= 18
  end
end
