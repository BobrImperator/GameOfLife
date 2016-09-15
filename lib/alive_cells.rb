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

class NextGeneration < Struct.new(:matrix)
    def next
      NextGeneration.new(next_generation)
    end

    def to_s
      matrix.map { |line| line.join('') + "\n" }.join()
    end

    def next_generation
        matrix.map.with_index do |row, y|
            row.map.with_index { |cell, x| dead_or_alive(cell, [x, y]) }
        end
  end

    def matrix_range
        0..(matrix.size - 1)
    end

    def dead_or_alive(cell, coordinates)
        if cell == 1
            case  live_neighbours(coordinates)
            when  0..1 then 0
            when 2..3 then 1
            else 0
            end

        else
            # binding.pry if coordinates == [3,2]
            if live_neighbours(coordinates) >= 3
                1
            else
                0
            end

        end
    end

    def live_neighbours(coordinates)
        neighbours(*coordinates).select { |cell| cell == 1 }.size
    end

    def neighbours(x, y)
        neighbours_coordinates(x, y).map { |nx, ny| matrix[ny][nx] }
    end

    def neighbours_coordinates(x, y)
        eight_directions.map { |vx, vy| [x + vx, y + vy] }.select { |nx, ny| matrix_range.include?(nx) && matrix_range.include?(ny) }
    end

    def eight_directions
        [
            [-1, -1], [0, -1], [1, -1],
            [-1, 0],         [1, 0],
            [-1, 1], [0, 1], [1, 1]
        ]
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
