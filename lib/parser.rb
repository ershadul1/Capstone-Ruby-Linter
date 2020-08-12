module Parser
  def char_separator(str)
    len = str.length - 1
    array = two_d_array_initializer(len, 2)
    line_num = 1
    char_num = 1
    (0..len).each do |i|
      array[i][0] = str[i]
      array[i][1] = char_num
      array[i][2] = line_num
      if str[i] == "\n"
        line_num += 1
        char_num = 1
      else
        char_num += 1
      end
    end
    array
  end

  def two_d_array_initializer(column, row)
    array = []
    (0..column).each do |i|
      array.push []
      (0..row).each do
        array[i] << ''
      end
    end
    array
  end
end
