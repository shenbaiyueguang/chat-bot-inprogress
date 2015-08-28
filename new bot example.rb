require_relative 'bot'
# encoding: UTF-8

bot = Bot.new(:name => "Evan", :data => "botdata")

puts bot.greeting

while input = gets and input.chomp != 'bye'
	if input[0...3] == "LMO"
		bot.learn
	elsif input == "DICT"
		bot.dictionary
	else
	puts ">>" + bot.response(input)
	end
end
puts bot.farewell
