class Memoize
  attr_reader :array

  def initialize(array)
    @array = array
  end

  def sorted
    @anything ||= array.sort
    #generate_sorted
    #@sorted = @sorted || generate_sorted
  end

  def generate_sorted
    puts "7777777777777777777777777"
    puts "Sorting!"
    array.sort
  end

  def average
    @average ||= generate_average
  end

  def generate_average
    puts "333333333333"
    puts "average"
    #array.reduce(0) { |memo, num| memo += num } / array.length
  end

end
