require_relative './person'

class Teacher < Person
  def initialize(specialization, _age, _name = 'unknown', _parent_permission: true)
    super()
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
