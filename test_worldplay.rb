require 'test/unit'
require_relative 'wordplay'

class TestWordPlay < Test::Unit::TestCase
	def test_sentences
		assert_equal(["a","b","c d","e f g"], "a.b.c d.e f g.".sentences)
		test_text = %q{hello. this is a test. it
even work. with different lines.}
		assert_equal("it even work", test_text.sentences[2])
	end
	def test_words
		assert_equal(%w[this is a test], "this is a test".words)
		assert_equal(%w[this does not even mean anything], "this, does not, even mean anything".words)
	end

end
