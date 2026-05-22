module Enumerable
  # Your code goes here
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    self.my_each do |e|
      yield(e,i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    result = []
    self.my_each do |e|
      result << e if yield(e)
    end
    result
  end

  def my_all?
    return to_enum(:my_all) unless block_given?

    self.my_each do |e|
      return false unless yield(e)
    end
    true
  end

  def my_any?
    return to_enum(:my_all) unless block_given?

    self.my_each do |e|
      return true if yield(e)
    end
    false
  end

  def my_none?
    return to_enum(:my_none) unless block_given?

    self.my_each do |e|
      return false if yield(e)
    end
    true
  end

  def my_count
    return self.size unless block_given?

    count = 0
    self.my_each do |e|
      count += 1 if yield(e)
    end
    count
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    result = []
    self.my_each do |e|
      result << yield(e)  
    end
    result
  end

  def my_inject(initial = nil)
    a = initial.nil? ? self[0] : initial
    start = initial.nil? ? 1 : 0

    self[start..-1].my_each do |e|
      a = yield(e,a)
    end
    return a 
  end

end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    return to_enum(:my_each) unless block_given?
      
    i = 0
    while i < self.length
      yield(self[i])
      i += 1
    end
  end
end

a = Array.new
a.my_each { |n| n }

# a.my_each_with_index do |e, i|
#   puts "#{i}: #{}"
# end
