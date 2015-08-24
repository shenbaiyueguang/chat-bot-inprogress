require_relative 'bot'

bot = Bot.new(:name => "Evan", :data => "botdata")

puts bot.greeting

while input = gets and input.chomp != 'bye'
	puts ">>" + bot.response(input)
end

puts bot.farewell
