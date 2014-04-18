require 'parser/current'
require 'erb'
require 'pry'


parsed = Parser::CurrentRuby.parse(%Q{
  puts 2+2
  puts 3+2
                                   })
processed = Processor.new.process_app(parsed)

File.open('main.go','w') {|f| f << processed }
`gofmt -w=true main.go`
