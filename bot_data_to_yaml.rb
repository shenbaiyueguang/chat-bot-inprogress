require 'yaml'

bot_data = {
	:presubs => [
		["dont", "don't"], 
		["youre", "your're"], 
		["love", "like"]
	],
	:responses => {
		:default =>[
			"I don't understand.",
			"What?",
			"Huh?"
		],
		:greeting => ["hi. I'm [name]. Want to chat?"],
		:farewell => ["BYE!"],
		'hello'	=> [
			"How's things going?",
			"How do you do?"
		],
		"I like *" => [
			"Why do you like *?",
			"wow! Me too!"
		] 
	}
}

f = File.open('botdata',"w+")
f.write bot_data.to_yaml
f.close