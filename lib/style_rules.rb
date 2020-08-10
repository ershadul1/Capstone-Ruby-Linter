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
      if counter > 1
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
        puts "Trailing-Space @ line: #{arr[i][2]}"
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
          puts "Blank-line @ line: #{arr[i][2]}"
          warnings += 1
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
      if arr[i][1] > 70 && arr[i][2] != line_num
        line_num = arr[i][2]
        puts "Exceed-Max-Line-Length @ line #{line_num}"
        warnings += 1
      end
    end
    warnings
  end
end
