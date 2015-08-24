require 'yaml'
require_relative 'wordplay'

class Bot
	attr_reader :name

	def initialize(options)
		@name = options[:name] || "Unnamed"
		begin
			@datapath = options[:data]
		rescue
			raise "Can't load bot data"
		end
		@data = YAML.load(File.read(@datapath))
	end

	def response(input)
		prepared_input = preprocess(input.downcase)
		sentence = process_sentence(prepared_input)
		response = possible_responses(sentence)
		response[rand(response.length)]
	end

	def greeting
		random_response(:greeting)
	end

	def farewell
		random_response(:farewell)
	end

	def add_unknown(sentence)
		f = File.open("unknownresponses", "a+")
		f.write sentence + "\n"
		f.close
	end

	private

	def random_response(key)
		random_index = rand(@data[:responses][key].length)
		@data[:responses][key][random_index].gsub(/\[name\]/, @name)
	end

	def preprocess(input)
		substitutions input
	end

	def substitutions(input)
		@data[:presubs].each { |sub| input.gsub!(sub[0], sub[1])}
		input
	end

	def process_sentence(input)
		hot_words = @data[:responses].keys.select do |s|
			s.class == String && s =~ /^\w=+$/
		end
		WordPlay.best_sentence(input.sentences, hot_words) 
	end

	def possible_responses(sentence)
		responses = []

		@data[:responses].keys.each do |pattern|
			next unless pattern.is_a?(String)
			if sentence.match('\b' + pattern.gsub(/\*/, '') + '\b') #''?""? i think it should be ""
				if pattern.include?('*')
					responses << @data[:responses][pattern].collect do |phrase|
						tempo = sentence.sub(/^.*#{pattern}\s+/, '')
						phrase.sub('*', WordPlay.switch_pronouns(tempo))
					end
				else
					responses << @data[:responses][pattern]
				end
			end
		end

		if responses.empty? == true
			responses << @data[:responses][:default]
			add_unknown(sentence)
		end

		responses.flatten
	end

end
