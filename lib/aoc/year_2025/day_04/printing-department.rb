module Aoc
  module Year2025
    class Day04
      def self.example_input
        <<-INPUT.strip
         ..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@. 
        INPUT
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      Cell = Data.define(:x, :y, :value)

      def parse(input)
        input.strip.lines.each_with_index.map do |row, row_index|
          row.strip.split('').each_with_index.map do |value, column_index|
            Cell.new(row_index, column_index, value)
          end
        end
      end

      def neighbors(grid, x, y)
        ((x - 1)..(x + 1)).flat_map do |neighbor_x|
          ((y - 1)..(y + 1)).map do |neighbor_y|
            next nil if neighbor_x == x && neighbor_y == y
            next nil if neighbor_x < 0 || neighbor_y < 0

            grid.fetch(neighbor_x, []).fetch(neighbor_y, nil)
          end
        end.compact
      end

      def part_one(input)
        grid = parse(input)

        grid.flatten.count do |cell|
          next unless cell.value == '@'

          neighbors(grid, cell.x, cell.y).count { it.value == '@' } < 4
        end
      end

      def part_two(input)
        grid = parse(input)

        cells_to_check = grid.flatten

        while (cell = cells_to_check.pop)
          next unless cell.value == '@'

          neighbors_to_check = neighbors(grid, cell.x, cell.y)

          next unless neighbors_to_check.count { it.value == '@' } < 4

          cells_to_check += neighbors_to_check
          grid[cell.x][cell.y] = Cell.new(cell.x, cell.y, 'R')
        end

        grid.flatten.count { it.value == 'R' }
      end
    end
  end
end
