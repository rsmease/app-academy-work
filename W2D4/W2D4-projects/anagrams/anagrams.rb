def first_anagram?(first, second) #O(n! + 2n)
  first.chars.permutation.include?(second.chars)
end

def second_anagram?(first, second) #O(mg this is ugly) #O(n**2)
  first_chars = first.chars
  second_chars = second.chars

  loop do
    break if first_chars.empty? && second_chars.empty?
    break if first_chars.none? { |char| second_chars.include?(char)}
    first_chars.each_index do |i|
      curr_char = first_chars[i]
      if second_chars.include?(curr_char)
        j = second_chars.index(curr_char)
        first_chars.delete_at(i)
        second_chars.delete_at(j)
        break
      end
    end
  end

  first_chars.empty? && second_chars.empty?
end

def third_anagram?(first, second) #O(4n)
  first.chars.sort == second.chars.sort
end

def fourth_anagram?(first, second) #O(3n)
  freq_map = Hash.new(0)

  first.chars.each { |char| freq_map[char]+= 1 }
  second.chars.each { |char| freq_map[char]-= 1 }

  freq_map.values.all? { |v| v == 0 }
end
