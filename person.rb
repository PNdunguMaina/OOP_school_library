require './nameable'

class Person < Nameable
  # getter and accessor methods
  attr_reader :id
  attr_accessor :name, :age, :rentals

  # constructor method
  def initialize(age, name = 'unknown', parent_permission: true)
    super()
    @id = Random.rand(1..10_000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  # public method
  def can_use_services?
    of_age? || parent_permission
  end

  # concrete components that provides default implementations of the method
  def correct_name
    @name
  end

  def add_rental(book, date)
    Rental.new(date, self, book)
  end

  private

  def of_age?
    @age >= 18
  end
end
