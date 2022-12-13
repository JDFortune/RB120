class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

trip = RoadTrip.new
p trip.predict_the_future

=begin

Benefits of object oriented programming
1. Better Organization of methods and objects in a program
2. can hide access to states in inside the classes
3. Encapsulation, like above this allows us to hide some funcationality and variable states within a class, so they can't be tampered with
4. Polymorphism - being able to iteratively call methods on different objects and receive different results from the method calls.
5. Being able to store methods and instance varirables locally within a class and instance of a class, makes dealing with the objects feel more controlled.
6. If one aspect of a program is broken, it doesn't ruin the whole program
7. Inheritance, and being able to gain behavior from a super class without having to re-write the message
8. Modules, mix-in behaviour easily without needing to type up multiple versions of the same method
9. It's DRYer.