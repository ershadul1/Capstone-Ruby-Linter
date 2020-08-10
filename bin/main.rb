require_relative '../lib/parser.rb'
require_relative '../lib/style_rules.rb'

class Linter
  include StyleRules
  include Parser

  def initialize(string)
    @string = string
    @arr = char_separator(@string)
  end
  
  def start_check
    redundant_space(@arr)
    trailing_space(@arr)
    blank_line(@arr)
    exceed_line_length(@arr)
  end
end

str = ''
File.open(ARGV[0]).each do |line|
  str << line
end

new_file = Linter.new(str)
new_file.start_check