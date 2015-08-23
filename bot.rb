require 'yaml'
require_relative 'wordplay'

class Bot
	attr_reader :name

	def initialize(options)
		@name = options[:name] || "Unnamed"
		begin
			@data = YAML.load(File.read(options[:data_file]))
		rescue
			raise "Can't load bot data"
		end
	end

	def response_to(input)
		prepared_input = preprocess(input).downcase
	end

	def greeting
		random_response(:greeting)
	end

	def farewell
		random_response(:farewell)
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
		@data[:presubs].each do {|sub| input.gsub!(sub[0], sub[1])}
	end
end
