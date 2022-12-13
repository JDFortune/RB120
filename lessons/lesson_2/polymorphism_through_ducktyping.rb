class Wedding
  attr_reader :guests, :flowers, :songs
  def initialize(guests, flowers, songs)
    @guests = guests
    @flowers = flowers
    @songs = songs
  end

  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_wedding(self)
    end
  end
end

class Chef
  def prepare_wedding(wedding)
    prepare_food(wedding.guests)
  end

  def prepare_food(guests)
    guests.each do |guest|
      puts "Chef preps food for #{guest}"
    end
  end
end

class Decorator
  def prepare_wedding(wedding)
    decorate_place(wedding.flowers)
  end

  def decorate_place(flowers)
    flowers.each do |flower|
      puts "Decorator: #{flower}"
    end
  end
end

class Musician
  def prepare_wedding(wedding)
    prepare_performance(wedding.songs)
  end

  def prepare_performance(songs)
    songs.each do |song|
      puts "Musician playing: #{song}"
    end
  end
end

guests = ["alan", 'roger']
flowers = ['chrisanthemum']
songs = ['how you love me dirty', 'did diddy do it (diddy do)']

matilda_wedding = Wedding.new(guests, flowers, songs)

preparers = [Chef.new, Decorator.new, Musician.new]

matilda_wedding.prepare(preparers)