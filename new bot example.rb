require 'bot'

bot = Bot.new(:name => "Evan", :data => "Evan.bot")

puts bot.greeting

while input = gets and input.chomp != 'bye'
	puts ">>" + bot.response(input)
end

puts bot.farewell
