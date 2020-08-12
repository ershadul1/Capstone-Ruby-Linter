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

describe StyleRules do
  linter_test = StyleRules.new 

  let(:test_arr) do
    [["d", 1, 1], ["e", 2, 1], ["f", 3, 1], [" ", 4, 1], ["a", 5, 1], ["d", 6, 1], ["d", 7, 1],
     ["\n", 8, 1], [" ", 1, 2], [" ", 2, 2], ["s", 3, 2], ["u", 4, 2], ["m", 5, 2], ["\n", 6, 2],
     ["e", 1, 3], ["n", 2, 3], ["d", 3, 3], ["\n", 4, 3]]
  end

  context '#redundant_space' do
    it 'when one redundant space included' do
      arr = [["i", 1, 1], ["f", 2, 1], [" ", 3, 1], [" ", 4, 1], ["a", 5, 1], [">", 6, 1], ["5", 6, 1]]
      expect(linter_test.redundant_space(arr)).to eql(1)
    end

    it 'when no redundant space included' do
      expect(linter_test.redundant_space(test_arr)).to eql(0)
    end
  end

  context '#trailing_space' do
    it 'when two trailing space included' do
      arr = [["d", 1, 1], ["e", 2, 1], ["f", 3, 1], [" ", 4, 1], ["a", 5, 1], ["d", 6, 1], ["d", 7, 1],
             [" ", 8, 1], ["\n", 9, 1], [" ", 1, 2], ["e", 2, 2], ["n", 3, 2], ["d", 4, 2], [" ", 5, 2], ["\n", 6, 2]]
      expect(linter_test.trailing_space(arr)).to eql(2)
    end

    it 'when no trailing space included' do
      expect(linter_test.trailing_space(test_arr)).to eql(0)
    end
  end

  context '#blank_line' do
    it 'when two blank lines are included' do
      arr = [["d", 1, 1], ["e", 2, 1], ["f", 3, 1], [" ", 4, 1], ["a", 5, 1], ["d", 6, 1], ["d", 7, 1],
             ["\n", 8, 1], [" ", 1, 2], [" ", 2, 2], ["\n", 3, 2], [" ", 1, 3], [" ", 2, 3], [" ", 3, 3],
             ["s", 4, 3], ["\n", 5, 3], [" ", 1, 4], [" ", 2, 4], [" ", 3, 4], [" ", 4, 4], ["\n", 5, 4],
             ["e", 1, 5], ["n", 2, 5], ["d", 3, 5]]
      expect(linter_test.blank_line(arr)).to eql(2)
    end

    it 'when no blank line included' do
      expect(linter_test.blank_line(test_arr)).to eql(0)
    end
  end

  context '#exceed_line_length' do
    it 'when maximum line length exceeded' do
      arr = [["d", 1, 1], ["e", 2, 1], ["f", 3, 1], [" ", 4, 1], ["a", 5, 1], ["d", 6, 1], ["d", 7, 1],
             [" ", 8, 1], ["h", 9, 1], ["e", 10, 1], ["l", 11, 1], ["l", 12, 1], ["o", 13, 1], [" ", 14, 1],
             ["d", 15, 1], ["e", 16, 1], ["f", 17, 1], [" ", 18, 1], ["a", 19, 1], ["d", 20, 1], ["d", 21, 1],
             [" ", 22, 1], ["h", 23, 1], ["e", 24, 1], ["l", 25, 1], ["l", 26, 1], ["o", 27, 1], [" ", 28, 1],
             ["d", 29, 1], ["e", 30, 1], ["f", 31, 1], [" ", 32, 1], ["a", 33, 1], ["d", 34, 1], ["d", 35, 1],
             [" ", 36, 1], ["h", 37, 1], ["e", 38, 1], ["l", 39, 1], ["l", 40, 1], ["o", 41, 1], [" ", 42, 1],
             ["d", 43, 1], ["e", 44, 1], ["f", 45, 1], [" ", 46, 1], ["a", 47, 1], ["d", 48, 1], ["d", 49, 1],
             [" ", 50, 1], ["h", 51, 1], ["e", 52, 1], ["l", 53, 1], ["l", 54, 1], ["o", 55, 1], [" ", 56, 1],
             ["d", 57, 1], ["e", 58, 1], ["f", 59, 1], [" ", 60, 1], ["a", 61, 1], ["d", 62, 1], ["d", 63, 1],
             [" ", 64, 1], ["h", 65, 1], ["e", 66, 1], ["l", 67, 1], ["l", 68, 1], ["o", 69, 1], [" ", 70, 1],
             ["d", 71, 1], ["e", 72, 1], ["f", 73, 1], [" ", 74, 1]]
      expect(linter_test.exceed_line_length(arr)).to eql(1)
    end

    it 'when maximum line length not exceeded' do
      expect(linter_test.exceed_line_length(test_arr)).to eql(0)
    end
  end

  context '#final_newline' do
    it 'when final empty newline included' do
      arr = [["d", 1, 1], ["e", 2, 1], ["f", 3, 1], [" ", 4, 1], ["a", 5, 1], ["d", 6, 1], ["d", 7, 1],
             [" ", 8, 1], ["\n", 9, 1], [" ", 1, 2], ["e", 2, 2], ["n", 3, 2], ["d", 4, 2], [" ", 5, 2], ["\n", 6, 2]]
      expect(linter_test.final_newline(arr)).to eql(true)
    end

    it 'when final empty newline not included' do
      arr = [["d", 1, 1], ["e", 2, 1], ["f", 3, 1], [" ", 4, 1], ["a", 5, 1], ["d", 6, 1], ["d", 7, 1],
             [" ", 8, 1], ["\n", 9, 1], [" ", 1, 2], ["e", 2, 2], ["n", 3, 2], ["d", 4, 2]]
      expect(linter_test.final_newline(arr)).to eql(false)
    end
  end

  context '#indentation' do
    it 'when indentation missing' do
      string = "def add\na + b\nend\n"
      arr = [["d", 1, 1], ["e", 2, 1], ["f", 3, 1], [" ", 4, 1], ["a", 5, 1], ["d", 6, 1], ["d", 7, 1],
             ["\n", 8, 1], ["a", 1, 2], [" ", 2, 2], ["+", 3, 2], [" ", 4, 2], ["b", 5, 2], ["\n", 6, 2],
             ["e", 1, 3], ["n", 2, 3], ["d", 3, 3], ["\n", 4, 3]]
      expect(linter_test.indentation(string, arr)).to eql(1)
    end

    it 'when no indentation missing' do
      string = "def add\n  a + b\nend\n"
      arr = [["d", 1, 1], ["e", 2, 1], ["f", 3, 1], [" ", 4, 1], ["a", 5, 1], ["d", 6, 1], ["d", 7, 1],
             ["\n", 8, 1], [" ", 1, 2], [" ", 2, 2], ["a", 3, 2], [" ", 4, 2], ["+", 5, 2], [" ", 6, 2],
             ["b", 7, 2], ["\n", 8, 2], ["e", 1, 3], ["n", 2, 3], ["d", 3, 3], ["\n", 4, 3]]
      expect(linter_test.indentation(string, arr)).to eql(0)
    end
  end

  context '#indentation_checker' do
    it 'when the given line contains proper indentation' do
      expect(linter_test.indentation_checker(test_arr, 2, 2)).to eql(true)
    end

    it 'when the given line does not contain proper indentation' do
      arr = [["d", 1, 1], ["e", 2, 1], ["f", 3, 1], [" ", 4, 1], ["a", 5, 1], ["d", 6, 1],
             ["d", 7, 1], ["\n", 8, 1], [" ", 1, 2], [" ", 2, 2], [" ", 3, 2], [" ", 4, 2],
             ["s", 5, 2], ["u", 6, 2], ["m", 7, 2], ["\n", 8, 2], ["e", 1, 3], ["n", 2, 3], ["d", 3, 3]]
      expect(linter_test.indentation_checker(arr, 2, 2)).to eql(false)
    end
  end
end
