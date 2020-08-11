module StyleRules
  def redundant_space(arr)
    counter = 0
    warnings = 0
    (0..arr.length - 1).each do |i|
      if arr[i][0] == ' '
        counter += 1
      else
        counter = 0
      end

      if counter > 1 and !indentation_checker(arr, arr[i][2], 2)
        puts "Redundant-Space @ line: #{arr[i][2]} column: #{arr[i][1]}"
        warnings += 1
      end
    end
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
    warnings
  end

  def final_newline(arr)
    return if arr[arr.length - 1][0] == "\n"

    puts "Final empty newline missing"
  end

  def indentation(str, arr)
    ruby_keywords = %w[class when def while for do if else elsif module unless case until]
    indentation = 0
    arr_one = str.split("\n")
    arr_one.each_with_index do |i, index|
      arr_two = i.split(' ')
      indentation -= 2 if arr_two.include?('end')
      if indentation > 1 and !indentation_checker(arr, index + 1, indentation)
        puts "Fix indentation on line #{index + 1}"
      end
      indentation += 2 unless (arr_two & ruby_keywords).empty?
    end
  end

  def indentation_checker(arr, line_num, spaces)
    result = 0
    (0..arr.length - 1).each do |i|
      next unless arr[i][2] == line_num

      (0..spaces - 1).each do |j|
        result += 1 if arr[i + j][0] == ' '
      end
      break
    end
    result == spaces
  end
end
