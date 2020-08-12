require_relative '../lib/parser.rb'
require_relative '../lib/style_rules.rb'

class Linter
  include Parser

  attr_reader :string, :arr

  def initialize(string)
    @string = string
    @arr = char_separator(@string)
  end

  def start_check
    test = StyleRules.new
    test.redundant_space(@arr)
    test.trailing_space(@arr)
    test.blank_line(@arr)
    test.exceed_line_length(@arr)
    test.final_newline(@arr)
    test.indentation(@string, @arr)
    test.total_num_of_issues
  end
end

str = ''
File.open(ARGV[0]).each do |line|
  str << line
end

new_file = Linter.new(str)
new_file.start_check
