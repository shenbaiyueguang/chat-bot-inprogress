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
            "Huh?",
            "我不知道你在说什么",
            "诶，什么？",
            "臣妾听不明白"

        ],
        :greeting => ["嘿你好！我是[name]。一起聊聊天吗？"],
        :farewell => ["BYE!"],
        "hello"    => [
            "How's things going?",
            "How do you do?",
            "why did you say hello" => [
                "wow this is obvious"
            ]
        ],
        "i like *" => [
            "Why do you like *?",
            "wow! Me too!"
        ] 
    }
}

bot_data[:responses] = bot_data[:responses].sort_by {|s| s[0].length}
bot_data[:responses].sort! { |x,y| y[0].length <=> x[0].length } 
bot_data[:responses] = bot_data[:responses].to_h
bot_data[:responses]
f = File.open('botdata',"w+")
f.write bot_data.to_yaml
f.close