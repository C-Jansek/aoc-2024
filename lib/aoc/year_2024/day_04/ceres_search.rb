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

      def cell_in_direction(grid, x, y, direction)
        x = x + DIRECTIONS[direction][0]
        y = y + DIRECTIONS[direction][1]
        grid[y][x]
      end

      def diagonal_words(grid, x, y)
        grid_width = grid[0].length
        grid_height = grid.length

        return [nil, nil] unless x.between?(1, grid_width - 2)
        return [nil, nil] unless y.between?(1, grid_height - 2)

        north_east_to_south_west = cell_in_direction(grid, x, y, :north_east) + grid[y][x] + cell_in_direction(grid, x, y, :south_west)
        south_east_to_north_west = cell_in_direction(grid, x, y, :south_east) + grid[y][x] + cell_in_direction(grid, x, y, :north_west)

        [north_east_to_south_west, south_east_to_north_west]
      end

      def part_two(input)
        grid = parse(input)

        grid.each_with_index.sum do |row, y|
          row.each_with_index.count do |_col, x|
            diagonal_words(grid, x, y).all? do |word|
              ['MAS', 'MAS'.reverse].include?(word)
            end
          end
        end
      end
    end
  end
end
