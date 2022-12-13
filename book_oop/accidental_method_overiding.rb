class Parent
  def say_hi
    p "Hi from Parent."
  end
end

class Child < Parent
  def say_hi
    p "Hi from Child."
  end

  def to_s
    "I am a child and I'm not ashamed"
  end
end

rupert = Child.new

rupert.send :say_hi

p rupert.instance_of? Child
p rupert.class == Child

puts rupert