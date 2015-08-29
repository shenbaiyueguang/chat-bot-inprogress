require_relative 'bot'
# encoding: UTF-8

bot = Bot.new(:name => "Evan", :data => "botdata")

puts bot.greeting
f = File.open("testfile", "r")
while input = f.readline and input.chomp != 'bye'
	puts input
	if input.chomp == "LMO"
		bot.learn
	elsif input.chomp == "DICT"
		bot.dictionary
	else
	puts ">>" + bot.response(input)
	end
end
puts 'bye'
puts bot.farewell
