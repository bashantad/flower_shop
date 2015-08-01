# Array extension
class Array

  def sum
    inject(&:+)
  end

  def exclude?(value)
    include?(value) == false
  end

  def multiplication
    inject(&:*)
  end

end