require 'yaml'
# encoding: UTF-8
bot_data = {
	:presubs => [
		[["dont"], "don't"], 
		[["youre"], "your're"], 
		[["love"], "like"]
	],
	:responses => {
		:default =>[
			"I don't understand.",
			"What?",
			"Huh?"
		],
		:greeting => ["嘿你好！我是[name]。一起聊聊天吗？"],
		:farewell => ["BYE!"],
		'hello'	=> [
			"How's things going?",
			"How do you do?"
		],
		"i like *" => [
			"Why do you like *?",
			"wow! Me too!"
		] 
	}
}

f = File.open('botdata',"w+")
f.write bot_data.to_yaml
f.close