require 'terminfo'

class Banner
  attr_reader :width, :message

  def initialize(message, width = nil)
    @message = message
    message.size > MAX && width.nil? || width > MAX ? @width = MAX : @width = width
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  MAX = 80

  def horizontal_rule
    if width
      "+-#{"-" * (width - 4)}-+"
    else
      "+-#{"-" * (message.size)}-+"
    end
  end

  def empty_line
    if width
      "| #{" " * (width - 4)} |"
    else
      "| #{" " * (message.size)} |"
    end
  end

  def split_message(length)
    idx = 0
    rows = []
    until idx >= message.size
      rows << message[idx, length]
      idx += length
    end
    filler = length - rows.last.size
    rows.last << (" " * filler)
    rows
  end

  def message_line
    return "| #{message} |" unless width
    message_rows = split_message(width - 4)
    message_rows.map { |row| "| #{row} |"}
  end
end

banner = Banner.new("To boldly go where no one has gone before. And this is how it all started. I guess you could say I've always been the adventerous type, but I didn't expect to be sent on a journey quite this incredible.", 79)

puts banner

p Terminfo.screen_size