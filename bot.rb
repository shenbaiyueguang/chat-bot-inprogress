require 'yaml'
# encoding: UTF-8
require_relative 'wordplay'
require_relative 'selfrewrite'

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
		@next = {}
		@next_existence = false
	end

	def response(input)
		prepared_input = preprocess(input.downcase)
		sentence = process_sentence(prepared_input)
		response = possible_responses(sentence.chomp)
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

	def learn
		@stimulus = ''
		@respondent = []
		puts ">>学习模式：开始"
		puts ">>请教给我新的姿势！"
		@stimulus = gets
		puts ">>我该说些什么呢？"
		while 1
			@k = gets
			if @k.chomp != 'L'
				@respondent << @k
			else
				break
			end
		end
		Self_rewrite.rewrite(preprocess(@stimulus), @respondent, @datapath)
		puts ">>学习模式：关闭"
		@data = YAML.load(File.read(@datapath))
	end

	def dictionary
		puts ">>path?"
		@dict_path = gets.chomp
		Self_rewrite.dictionary_input(@dict_path, @datapath)
		puts ">>字典录入完成!"
		@data = YAML.load(File.read(@datapath))
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
		@data[:presubs].each {|sub| sub[0].each {|subs| input.gsub!(subs, sub[1])}}
		input
	end

	def process_sentence(input)
		hot_words = @data[:responses].keys.select do |s|
			s.class == String && s =~ /^\w=+$/
		end
		WordPlay.best_sentence(input.sentences, hot_words) 
	end

	def possible_responses(sentence)
		@responses = []
		find_responses_in(@next, sentence)
		find_responses_in(@data[:responses], sentence) if @responses.empty? == true
		if @responses.empty? == true
			@responses << @data[:responses][:default]
			add_unknown(sentence)
		end
		@next = {} if @next_existence == false
		@next_existence = false
		@responses.flatten
	end


	def find_responses_in(group, sentence)
		group.keys.each do |pattern|
			next unless pattern.is_a?(String)
			if sentence.match(pattern.gsub(/\*/, '') ) 
				if pattern.include?('*')
					group[pattern].collect do |phrase|
						if phrase.is_a?(String)
							tempo = sentence.sub(/^.*#{pattern}\s+/, '')
							@responses << phrase.sub('*', WordPlay.switch_pronouns(tempo))
						elsif phrase.is_a?(Hash)
							@next.merge!(phrase) 
							@next_existence = true
						end
					end
				else
					group[pattern].collect do |phrase|
						if phrase.is_a?(String)
							@responses << phrase
						elsif phrase.is_a?(Hash)
							@next.merge!(phrase) 
							@next_existence = true
						end
					end
				end
				break
			end
		end
		
	end


end
