require_relative '../lib/parser.rb'
require_relative '../lib/style_rules.rb'

describe Parser do
  include Parser
  context '#two_d_array_initializer' do
    it 'when an array of 4 columns and 3 rows is generated' do
      expect(two_d_array_initializer(3, 2)).to eql([['', '', ''], ['', '', ''], ['', '', ''], ['', '', '']])
    end

    it 'when an array of 4 columns and 2 rows is generated' do
      expect(two_d_array_initializer(3, 1)).to eql([['', ''], ['', ''], ['', ''], ['', '']])
    end
  end

  context '#char_separator' do
    it 'when a string is passed to char_separator' do
      string = "puts 'Hello! World"
      expect(char_separator(string)).to eql([["p", 1, 1], ["u", 2, 1], ["t", 3, 1], ["s", 4, 1], [" ", 5, 1],
                                             ["'", 6, 1], ["H", 7, 1], ["e", 8, 1], ["l", 9, 1], ["l", 10, 1],
                                             ["o", 11, 1], ["!", 12, 1], [" ", 13, 1], ["W", 14, 1], ["o", 15, 1],
                                             ["r", 16, 1], ["l", 17, 1], ["d", 18, 1]])
    end

    it 'when a string with new-line passed to char_separator' do
      string = "def add
      end"
      expect(char_separator(string)).to eql([["d", 1, 1], ["e", 2, 1], ["f", 3, 1], [" ", 4, 1],
                                             ["a", 5, 1], ["d", 6, 1], ["d", 7, 1], ["\n", 8, 1],
                                             [" ", 1, 2], [" ", 2, 2], [" ", 3, 2], [" ", 4, 2],
                                             [" ", 5, 2], [" ", 6, 2], ["e", 7, 2], ["n", 8, 2], ["d", 9, 2]])
    end
  end
end
