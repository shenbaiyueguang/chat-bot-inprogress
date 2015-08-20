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