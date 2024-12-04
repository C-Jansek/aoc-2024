module Aoc
  module Year2024
    class Day04
      def self.example_input_part_one
        <<-MSG.strip
          MMMSXXMASM
          MSAMXMSMSA
          AMXSXMAAMM
          MSAMASMSMX
          XMASAMXAMM
          XXAMMXXAMA
          SMSMSASXSS
          SAXAMASAAA
          MAMMMXMMMM
          MXMXAXMASX
        MSG
      end

      def self.example_input_part_two
        <<-MSG.strip
        MSG
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        input.strip.lines.map do |line|
          line.strip.split('')
        end
      end

      SEARCH_WORD = 'XMAS'

      DIRECTIONS = {
        north: [0, -1],
        north_west: [1, -1],
        west: [1, 0],
        south_west: [1, 1],
        south: [0, 1],
        south_east: [-1, 1],
        east: [-1, 0],
        north_east: [-1, -1],
      }

      def possible_words(grid, x, y, word_length = SEARCH_WORD.length)
        grid_width = grid[0].length
        grid_height = grid.length

        DIRECTIONS.each_value.map do |direction_coordinates|
          next unless (x + (word_length - 1) * direction_coordinates[0]).between?(0, grid_width - 1)
          next unless (y + (word_length - 1) * direction_coordinates[1]).between?(0, grid_height - 1)

          word = ''
          word_length.times do |offset|
            x_coordinate = x + offset * direction_coordinates[0]
            y_coordinate = y + offset * direction_coordinates[1]
            word += grid[y_coordinate][x_coordinate]
          end

          word
        end.reject(&:nil?)
      end

      def part_one(input)
        grid = parse(input)

        total = 0

        grid.each.with_index do |row, y|
          row.each.with_index do |_col, x|
            total += possible_words(grid, x, y).count do |word|
              word == SEARCH_WORD
            end
          end
        end

        total
      end

      def diagonal_words(grid, x, y)
        grid_width = grid[0].length
        grid_height = grid.length

        # puts "x: #{x} between #{1} #{grid_width - 2}: #{x.between?(1, grid_width - 2)}"

        return [nil, nil] unless x.between?(1, grid_width - 2)
        return [nil, nil] unless y.between?(1, grid_height - 2)

        north_east_to_south_west = grid[DIRECTIONS[:north_east][1] + y][ DIRECTIONS[:north_east][0] + x] + grid[y][x] + grid[DIRECTIONS[:south_west][1] + y][ DIRECTIONS[:south_west][0] + x]
        south_east_to_north_west = grid[DIRECTIONS[:south_east][1] + y][DIRECTIONS[:south_east][0] + x] + grid[y][x] + grid[DIRECTIONS[:north_west][1] + y][DIRECTIONS[:north_west][0] + x]

        [north_east_to_south_west, south_east_to_north_west]
      end

      def part_two(input)
        grid = parse(input)

        total = 0

        grid.each.with_index do |row, y|
          row.each.with_index do |_col, x|
            total += 1 if diagonal_words(grid, x, y).all? do |word|
              word == 'MAS' || word == 'MAS'.reverse
            end
          end
        end

        total
      end
    end
  end
end
