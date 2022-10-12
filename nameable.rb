# create base component interface
# defines methods altered by decorators
class Nameable
  def correct_name
    raise NotImplementedError
  end
end
