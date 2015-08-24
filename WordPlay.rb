class String
	def sentences
		gsub(/\n|\r/,' ').split(/\.\s*/)
	end
	
	def words
		scan(/\w[\w\'\-]*/)
	end

end

class WordPlay
	def self.switch_pronouns(text)
		text.gsub(/\b(You are|I am|I|You|Your|My|me|Are you)\b/i) do |pronoun|
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
			end
		end.sub(/^me\b/i, 'i')
	end

	def self.best_sentence(sentences, desired_words)
		ranked_sentence = sentences.sort_by do |s|
			s.words.length - (s.downcase.words - desired_words).length
		end

		ranked_sentence.last
	end


end

=begin

while input = gets
	if input[0...4].downcase.chomp == 'am i'
		puts '>>no.'
		next
	end
	puts '>>' + WordPlay.switch_pronouns(input).chomp + '?'
end
=end
