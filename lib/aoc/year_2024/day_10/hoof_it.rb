module Aoc
  module Year2024
    class Day10
      def self.example_input
        <<-MSG.strip
          89010123
          78121874
          87430965
          96549874
          45678903
          32019012
          01329801
          10456732
        MSG
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        input.strip.lines.map do |line|
          line.strip.split('').map(&:to_i)
        end
      end

      def get_neighbours(grid, x, y)
        Day06::DIRECTIONS.map do |_name, direction|
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

      def get_trailheads(grid)
        grid.each_with_index.map do |row, y|
          row.each_with_index.map do |cell, x|
            next {
              value: cell,
              x: x,
              y: y
            } if cell == 0

            nil
          end
        end.flatten.compact
      end

      def follow_trailheads(trailheads, grid)
        trailheads.map do |cell|
          new_neighbours = [cell]

          (1..9).each do |index|
            # puts index
            # puts new_neighbours.map{|neighbour| neighbour[:value]}.inspect
            new_neighbours = new_neighbours.map do |old_neighbour|
              get_neighbours(grid, old_neighbour[:x], old_neighbour[:y])
            end
            new_neighbours = new_neighbours.flatten.uniq.select do |new_neighbour|
              new_neighbour[:value] == index
            end
          end

          new_neighbours.flatten.count
        end.sum
      end

      def determine_trailheads_rating(trailheads, grid)
        trailheads.map do |cell|
          cell[:rating] = 1
          new_neighbours = [cell]

          (1..9).each do |index|
            new_neighbours = new_neighbours.map do |old_neighbour|
              get_neighbours(grid, old_neighbour[:x], old_neighbour[:y]).map do |neighbour|
                neighbour[:rating] = old_neighbour[:rating]
                neighbour
              end
            end

            unfiltered_neighbours = new_neighbours.flatten.select do |new_neighbour|
              new_neighbour[:value] == index
            end

            new_neighbours = unfiltered_neighbours.group_by do |new_neighbour|
              [new_neighbour[:x], new_neighbour[:y]]
            end.map do |coordinates, neighbours|
              merged = neighbours[0]
              merged[:rating] = neighbours.sum { |n| n[:rating] }
              merged
            end
          end

          new_neighbours.flatten.sum do |neighbour|
            neighbour[:rating]
          end
        end.sum
      end

      def part_one(input)
        grid = parse(input)

        trailheads = get_trailheads(grid)

        follow_trailheads(trailheads, grid)
      end

      def part_two(input)
        grid = parse(input)

        trailheads = get_trailheads(grid)
        determine_trailheads_rating(trailheads, grid)
      end
    end
  end
end
