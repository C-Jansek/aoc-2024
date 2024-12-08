module Aoc
  module Year2024
    class Day08
      def self.example_input
        <<-MSG.strip
          ............
          ........0...
          .....0......
          .......0....
          ....0.......
          ......A.....
          ............
          ............
          ........A...
          .........A..
          ............
          ............
        MSG
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        antennas = input.strip.lines.each_with_index.each_with_object({}) do |(row, y), antennas|
          row.strip.split('').each_with_index do |character, x|
            antennas[character] = antennas.fetch(character, []) + [[x, y]] unless character == '.'
          end
        end

        {
          antennas: antennas,
          width: input.strip.lines[0].strip.size,
          height: input.strip.lines.size
        }
      end

      def find_antinodes_to_the_side(a, b)
        # from b to a
        x_difference = a[0] - b[0]
        y_difference = a[1] - b[1]

        [
          [a[0] + x_difference, a[1] + y_difference],
          [b[0] - x_difference, b[1] - y_difference]
        ]
      end

      def find_all_antinodes_to_the_side(points)
        antinodes = Set.new

        points.each do |point_a|
          points.each do |point_b|
            next if point_a == point_b

            antinodes += find_antinodes_to_the_side(point_a, point_b)
          end
        end

        antinodes
      end

      def find_antinodes(a, b, width, height)
        # from b to a
        x_difference = a[0] - b[0]
        y_difference = a[1] - b[1]

        antinodes = [a, b]

        index = 1
        while Day06.inside_map(antinodes.first, height, width)
          antinodes.unshift([
                              a[0] + index * x_difference,
                              a[1] + index * y_difference
                            ])
          index += 1
        end
        antinodes.shift

        index = 1
        while Day06.inside_map(antinodes.last, height, width)
          antinodes.append([
                             b[0] - index * x_difference,
                             b[1] - index * y_difference
                           ])
          index += 1
        end
        antinodes.pop

        antinodes
      end

      def find_all_antinodes(points, width, height)
        antinodes = Set.new

        points.each do |point_a|
          points.each do |point_b|
            next if point_a == point_b

            antinodes += find_antinodes(point_a, point_b, width, height)
          end
        end

        antinodes
      end

      def part_one(input)
        parsed = parse(input)
        antennas = parsed.dig(:antennas)
        width = parsed.dig(:width)
        height = parsed.dig(:height)

        all_antinodes = Set.new

        antennas.each do |frequency, points|
          antinodes = find_all_antinodes_to_the_side(points)

          antinodes_inside_map = antinodes.select do |antinode|
            Day06.inside_map(antinode, width, height)
          end

          all_antinodes += antinodes_inside_map
        end

        all_antinodes.count
      end

      def part_two(input)
        parsed = parse(input)
        antennas = parsed.dig(:antennas)
        width = parsed.dig(:width)
        height = parsed.dig(:height)

        all_antinodes = Set.new

        antennas.each do |frequency, points|
          all_antinodes += find_all_antinodes(points, width, height)
        end

        all_antinodes.count
      end
    end
  end
end
