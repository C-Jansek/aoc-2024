module Aoc
  module Year2024
    class Day12
      def self.example_input
        <<-INPUT.strip
          RRRRIICCFF
          RRRRIICCCF
          VVRRRCCFFF
          VVRCCCJFFF
          VVVVCJJCFE
          VVIVCCJJEE
          VVIIICJJEE
          MIIIIIJJEE
          MIIISIJEEE
          MMMISSJEEE
        INPUT
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        input.strip.lines.map do |line|
          line.strip.split('')
        end
      end

      def get_neighbours(grid, x, y)
        Day10.new.get_neighbours(grid, x, y)
      end

      def find_fencing_cost(grid, region_identifier)
        grid_cells = grid.each_with_index.map do |row, y|
          row.each_with_index.map do |cell, x|
            {
              x: x,
              y: y,
              value: cell
            }
          end
        end.flatten

        region_cells = grid_cells.flatten.select do |cell|
          cell[:value] == region_identifier
        end

        puts region_cells.map{|c| c[:value]}.inspect

        area = region_cells.count
        perimeter = region_cells.sum do |cell|
          4 - get_neighbours(grid, cell[:x], cell[:y]).count do |neighbour|
            neighbour[:value] == region_identifier
          end
        end

        puts "#{area} * #{perimeter} = area * perimeter"
        area * perimeter
      end

      def part_one(input)
        parsed = parse(input)
        regions = parsed.flatten.uniq

        regions.map do |region|
          find_fencing_cost(grid, region)
        end.sum
      end

      def part_two(input)
        parsed = parse(input)

        nil
      end
    end
  end
end
