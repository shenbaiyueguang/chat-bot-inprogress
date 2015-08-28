=begin

class Person
attr_accessor :name
end

def add(name)
	Person.class_eval "
		attr_accessor :#{name}
	"
end

while input = gets
	eval "add(:#{input})"
	file = File.new("selfrewrite.rb","r+")
	context = file.read
	context.insert(context.split("Person")[0].length+7,"attr_accessor :#{input}")
	file.pos = 0
	file.write context
	file.close
	puts '>> done'
end
=end

require 'yaml'
class Self_rewrite
	def self.rewrite(stimulus, response, path)
		@data = YAML.load(File.read(path))
		@data[:responses][stimulus.chomp] = [] if @data[:responses][stimulus.chomp].class == nil.class
		p @data[:responses][stimulus.chomp]
		p response
		response.each {|s| @data[:responses][stimulus.chomp] << s.chomp}
		Self_rewrite.write_database(@data, path)
	end

	def self.dictionary_input(dictpath, path)
		@dict = File.new("dictpath","r")
		@data = YAML.load(File.read(path))
		dictionary_inputs = []
		while @dict.eof == false
			string = f.readline
			dictionary_inputs << string.scan(/【.*】/).to_s.gsub("【", "").gsub("】", "").gsub("[", "").gsub("]", "").gsub("\"", "") if string.match(/【.*】/)
		end
		dictionary_inputs.each {|s| @data[:responses] << s.chomp}
		Self_rewrite.write_database(@data, path)
	end

	private

	def self.write_database(data, path)
		f = File.open(path, "w+")
		f.write @data.to_yaml
		f.close				
	end
end