

Hot_words = %w{test ruby}

=begin

teststring = %q{hello. this is a test. it
				even work with different lines.}
teststring.sentences.find_all do |sentence|
	sentence.downcase.words.any?{|word| puts sentence if Hot_words.include?(word) }
end
=end

