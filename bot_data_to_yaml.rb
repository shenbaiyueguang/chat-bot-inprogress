require 'yaml'
=begin
name = Bot.Name
thing = Bot.thing
=end


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
		:greeting => ["hi. I'm *. Want to chat?"],
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

f = File.open('bot_data',"w+")
f.write bot_data.to_yaml
f.close