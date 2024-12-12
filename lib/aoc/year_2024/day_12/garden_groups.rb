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

      def get_neighbours(grid, x, y, directions = Day06::DIRECTIONS)
        directions.map do |_name, direction|
          neighbour_x = x + direction[0]
          neighbour_y = y + direction[1]
          if Day06.inside_map([neighbour_x, neighbour_y], grid.size, grid[0].size)
            {
              value: grid[neighbour_y][neighbour_x],
              x: neighbour_x,
              y: neighbour_y
            }
          else
            nil
          end
        end.compact
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

      def find_fencing_cost_with_sides(grid, region_identifier)
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

        identifier_cells = grid_cells.flatten.select do |cell|
          cell[:value] == region_identifier
        end

        puts "#{identifier_cells.size} cells for #{region_identifier}"

        regions = separate_regions_of_same_identifier(grid, region_identifier, identifier_cells)

        puts "regions: #{regions.map(&:size)}"

        puts "region_costs = #{regions.map { | region | fencing_cost_for_region_with_sides(grid, region) }}"

        regions.sum do |region|
          fencing_cost_for_region_with_sides(grid, region)
        end
      end

      def separate_regions_of_same_identifier(grid, region_identifier, identifier_cells)
        individual_regions = []

        while identifier_cells.any?
          completed_region_cells = Set.new
          new_region_cells = [identifier_cells.pop]

          while new_region_cells.any?
            check_cell = new_region_cells.pop

            region_neighbours = get_neighbours(grid, check_cell[:x], check_cell[:y]).select do |neighbour|
              neighbour[:value] == region_identifier
            end

            region_neighbours.each do |neighbour|
              new_region_cells << neighbour unless completed_region_cells.include?(neighbour) || new_region_cells.include?(neighbour)

              identifier_cells.delete(neighbour)
            end

            completed_region_cells << check_cell
          end

          individual_regions << completed_region_cells
        end

        individual_regions
      end

      def fencing_cost_for_region_with_sides(grid, region_cells)
        sorted_cells = region_cells.sort do |a, b|
          next 1 if a[:y] > b[:y]
          next -1 if a[:y] < b[:y]

          next a[:x] <=> b[:x]
        end

        puts "sorted_cells: #{sorted_cells.map {|cell| [cell[:x], cell[:y]]}.inspect}"

        cell_to_sides_modifier = sorted_cells.map do |cell|
          puts "cell: #{cell[:x]}, #{cell[:y]}"
          neighbours = get_neighbours(grid, cell[:x], cell[:y], RELATIVE_POSITION).select do |neighbour|
            cell[:value] == neighbour[:value]
          end

          unless [:east, :north].any?{|direction| neighbour_in_direction?(cell, neighbours, RELATIVE_POSITION[direction])}
            puts "nothing above or to the left, so 4"
            next 4
          end

          if neighbours.one?
            puts "Just one adjacent, so 0"
            next 0
          end

          if neighbours.count == 2 && [:east, :north_west].all?{|direction| neighbour_in_direction?(cell, neighbours, RELATIVE_POSITION[direction])}
            puts "Just one adjacent (diagonal unimportant), so 0"
            next 0
          end

          if !neighbour_in_direction?(cell, neighbours, RELATIVE_POSITION[:east]) && neighbours.count == 3
            puts "Splits previous line, so 4"
            next 4
          end

          if [:east, :north, :north_west].all?{|direction| neighbour_in_direction?(cell, neighbours, RELATIVE_POSITION[direction])}
            puts "Almost engulfed, so 0"
            next 0
          end

          if [:east, :north].all?{|direction| neighbour_in_direction?(cell, neighbours, RELATIVE_POSITION[direction])}
            puts "completes the square, so -2"
            next -2
          end

          puts "leftover, so 2"
          2
        end

        puts "cell to sides: ", sorted_cells.map {|cell| [cell[:x], cell[:y]]}.zip(cell_to_sides_modifier).inspect

        area = sorted_cells.size
        sides = cell_to_sides_modifier.sum

        puts "area * sides = #{area} * #{sides} = #{area * sides}"
        area * sides
      end

      def neighbour_in_direction?(cell, neighbours, direction)
        neighbours.any? do |neighbour|
          neighbour[:x] == cell[:x] + direction[0] &&
            neighbour[:y] == cell[:y] + direction[1]
        end
      end

      RELATIVE_POSITION = {
        east: [-1, 0],
        north_east: [-1, -1],
        north: [0, -1],
        north_west: [1, -1],
      }

      def part_one(input)
        grid = parse(input)
        region_identifiers = grid.flatten.uniq

        region_identifiers.map do |region_identifier|
          find_fencing_cost(grid, region_identifier)
        end.sum
      end

      def part_two(input)
        grid = parse(input)
        region_identifiers = grid.flatten.uniq

        region_identifiers.map do |region_identifier|
          find_fencing_cost_with_sides(grid, region_identifier)
        end.sum
      end
    end
  end
end
