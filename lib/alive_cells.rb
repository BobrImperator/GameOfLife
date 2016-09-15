require 'pry'

class TranslateToMatrix < Struct.new(:grid_as_numbers)
    def translate_char(character)
        case character
        when '*' then 1
        when '.' then 0
        end
    end

    def elements(line)
        line.split('').map { |each| translate_char(each) }
    end

    def lines
        grid_as_numbers.split("\n")
    end

    def matrix
        lines.map { |line| elements(line) }
    end
end


input = '.........*
.*.*...*..
..........
..*.*....*
.*..*...*.
.........*
..........
.....*..*.
.*....*...
.....**...
'

# input_translate_test = TranslateToMatrix.new(input)
# input_translate_test.matrix
# next_generation = NextGeneration.new(input_translate_test.matrix)
# 1.times { next_generation = next_generation.next }
# puts next_generation

output = '..........
...*......
..*.*.....
..*.*.....
...*......
..........
..........
..........
..........
..........
'

# Print to stdout the state of the grid after 10 iterations. E.g.
