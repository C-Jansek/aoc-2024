module Aoc
  module Year2025
    class Day09
      def self.example_input
        <<~INPUT.strip
          7,1
          11,1
          11,7
          9,7
          9,5
          2,5
          2,3
          7,3 
        INPUT
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      RedTile = Data.define(:x, :y)

      def parse(input)
        input.strip.lines.map do |row|
          RedTile.new(*row.strip.split(',').map(&:to_i))
        end
      end

      def self.area(point_a, point_b)
        ((point_b.x - point_a.x).abs + 1) *
          ((point_b.y - point_a.y).abs + 1)
      end

      def part_one(input)
        red_tiles = parse(input)

        max = 0

        red_tiles.each do |a|
          red_tiles.each do |b|
            max = [self.class.area(a, b), max].max
          end
        end

        max
      end

      def self.print_tile(tile)
        "(#{tile.x}, #{tile.y})"
      end

      def self.lines_from_corners(corners)
        corners.each_cons(2) + [[corners.last, corners.first]]
      end

      def self.lines_crossed_at(x, y, lines)
        # puts "Test (#{x}, #{y})"

        lines.count do |line|
          # puts "versus line #{print_tile(line.first)} -> #{print_tile(line.last)}"
          if y.clamp(*[line.first.y, line.last.y].sort) == y && x.clamp(*[line.first.x, line.last.x].sort) == x
            # puts "on the line #{print_tile(line.first)} -> #{print_tile(line.last)}"
            # On the line is always inside!
            return 1
          end

          # If line is not touching the same height
          next false unless y.clamp(*[line.first.y, line.last.y].sort) == y

          # If line is not before point
          next false if [x, line.first.x, line.last.x].sort[0] == x

          # puts "right of #{print_tile(line.first)} -> #{print_tile(line.last)}"
          next true
        end
      end

      def part_two(input)
        corner_tiles = parse(input)

        lines = self.class.lines_from_corners(corner_tiles)

        max = 0

        cache = {}
        x_coords_to_check = corner_tiles.map(&:x).uniq
        y_coords_to_check = corner_tiles.map(&:y).uniq
        corner_tiles.each_with_index do |a, index|
          corner_tiles[(index+1)..-1].each do |b|
            next unless self.class.area(a, b) > max

            next unless x_coords_to_check.map { it.clamp(*[a.x, b.x].sort) }.uniq.all? do |x|
              y_coords_to_check.map { it.clamp(*[a.y, b.y].sort) }.uniq.all? do |y|
                cache[x] ||= {}
                cache[x][y] ||= self.class.lines_crossed_at(x, y, lines)
                cache[x][y] % 2 == 1
              end
            end

            max = [self.class.area(a, b), max].max
          end
        end

        max
      end
    end
  end
end
