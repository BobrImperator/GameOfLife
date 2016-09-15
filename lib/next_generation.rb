class NextGeneration < Struct.new(:matrix)
    def next
        NextGeneration.new(next_generation)
    end

    def to_s
        matrix.map { |line| line.join('') + "\n" }.join
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
            if live_neighbours(coordinates) == 3
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
