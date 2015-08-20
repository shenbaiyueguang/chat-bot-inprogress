class WordPlay
	def self.switch_pronouns(text)
		text.gsub(/\b(You are|I am|I|You|Your|My|me|Are you|don't you)\b/i) do |pronoun|
			case pronoun.downcase
			when "i"
				"you"
			when "you"
				"me"
			when "me"
				"you"
			when "i am"
				"you are"
			when "am i"
				"you are"
			when "you are"
				"I am"
			when "your"
				"my"
			when "are you"
				"I am"
			when "my"
				"your"
			when "don't you"
				"do i"
			end
		end.sub(/^me\b/i, 'i')
	end

	


end
=begin

teststring = "you make me happy"
puts WordPlay.switch_pronouns(teststring)=end
=end
while input = gets
	if input[0...4].downcase.chomp == 'am i'
		puts '>>no.'
		next
	end
	puts '>>' + WordPlay.switch_pronouns(input).chomp + '?'
end
