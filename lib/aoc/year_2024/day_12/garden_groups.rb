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
        puts
        puts "start checking #{region_identifier}"

        grid_cells = grid.each_with_index.map do |row, y|
          row.each_with_index.map do |cell, x|
            {
              x: x,
              y: y,
              value: cell
            }
          end
        end.flatten

        region_identifier_cells = grid_cells.flatten.select do |cell|
          cell[:value] == region_identifier
        end

        total_cost_for_region_identifier = 0
        while region_identifier_cells.any?
          # puts "region_identifier_cells left: #{region_identifier_cells.count}"
          completed_region_cells = Set.new
          perimeter = 0
          area = 0
          new_region_cells = [region_identifier_cells.pop]

          while new_region_cells.any?
            # puts "completed_region_cells :#{completed_region_cells.count}"
            check_cell = new_region_cells.pop

            region_neighbours = get_neighbours(grid, check_cell[:x], check_cell[:y]).select do |neighbour|
              neighbour[:value] == region_identifier
            end

            region_neighbours.each do |neighbour|
              new_region_cells << neighbour unless completed_region_cells.include?(neighbour) || new_region_cells.include?(neighbour)

              region_identifier_cells.delete(neighbour)
            end

            area += 1
            perimeter += 4 - region_neighbours.size
            completed_region_cells << check_cell
          end


          puts "#{area} * #{perimeter} = area * perimeter"
          total_cost_for_region_identifier += area * perimeter
        end

        total_cost_for_region_identifier
      end

      def part_one(input)
        grid = parse(input)
        region_identifiers = grid.flatten.uniq

        region_identifiers.map do |region_identifier|
          find_fencing_cost(grid, region_identifier)
        end.sum
      end

      def part_two(input)
        grid = parse(input)

        nil
      end
    end
  end
end
