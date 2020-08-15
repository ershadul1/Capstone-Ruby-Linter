class StyleRules
  attr_reader :total_warnings

  KEYWORDS = %w[class when def while for do if else elsif module unless case until].freeze

  def initialize
    @total_warnings = 0
  end

  def redundant_space(arr)
    counter = 0
    warnings = 0
    (0..arr.length - 1).each do |i|
      arr[i][0] == ' ' ? counter += 1 : counter = 0
      if counter > 1 and !a_indentation_space?(arr, arr[i][2], arr[i][1])
        puts "Redundant-Space @ line: #{arr[i][2]} column: #{arr[i][1]}"
        warnings += 1
      end
    end
    @total_warnings += warnings
    warnings
  end

  def trailing_space(arr)
    warnings = 0
    (0..arr.length - 1).each do |i|
      if arr[i][0] == "\n" && arr[i - 1][0] == ' '
        puts "Trailing-White-Space @ line: #{arr[i][2]}"
        warnings += 1
      end
    end
    @total_warnings += warnings
    warnings
  end

  def blank_line(arr)
    warnings = 0
    blank_line = 0
    (0..arr.length - 1).each do |i|
      if arr[i][0] == "\n"
        blank_line += 1
        if blank_line == 2
          unless arr[i - 4][0] + arr[i - 3][0] + arr[i - 2][0] == 'end'
            puts "Blank-line @ line: #{arr[i][2]}"
            warnings += 1
          end
          blank_line = 1
        end
      elsif arr[i][0] == ' '
        blank_line = blank_line
      else
        blank_line = 0
      end
    end
    @total_warnings += warnings
    warnings
  end

  def exceed_line_length(arr)
    line_num = 0
    warnings = 0
    (0..arr.length - 1).each do |i|
      next unless arr[i][1] > 70 && arr[i][2] != line_num

      line_num = arr[i][2]
      puts "Exceed-Max-Line-Length(70) @ line #{line_num}"
      warnings += 1
    end
    @total_warnings += warnings
    warnings
  end

  def final_newline(arr)
    return true if arr[arr.length - 1][0] == "\n"

    @total_warnings += 1
    puts "Final empty newline missing"
    false
  end

  def indentation(str, arr)
    warnings = 0
    indentation = 0
    arr_one = str.split("\n")
    arr_one.each_with_index do |i, index|
      arr_two = i.split(' ')
      indentation -= 2 if arr_two.include?('end')
      unless required_indentation_exists(arr, index + 1, indentation)
        puts "Fix indentation @ line #{index + 1}"
        warnings += 1
      end
      indentation += 2 unless (arr_two & KEYWORDS).empty?
    end
    @total_warnings += warnings
    warnings
  end

  def total_num_of_issues
    if @total_warnings.zero?
      puts "Congratulations! no issues found"
    else
      puts "You have #{@total_warnings} warnings in your file"
    end
  end

  private

  def indentation_checker(arr, line_num)
    result = 0
    (0..arr.length - 1).each do |i|
      next unless arr[i][2] == line_num

      j = i
      while arr[j][0] == ' '
        result += 1
        j += 1
      end
      break
    end
    result
  end

  def required_indentation_exists(arr, line_num, spaces)
    spaces == indentation_checker(arr, line_num)
  end

  def a_indentation_space?(arr, line_num, column_num)
    column_num <= indentation_checker(arr, line_num)
  end
end
