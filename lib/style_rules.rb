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
end
