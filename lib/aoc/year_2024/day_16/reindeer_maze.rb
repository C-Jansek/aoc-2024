module Aoc
  module Year2024
    class Day16
      def self.small_example_input
        <<-INPUT.strip
          ###############
          #.......#....E#
          #.#.###.#.###.#
          #.....#.#...#.#
          #.###.#####.#.#
          #.#.#.......#.#
          #.#.#####.###.#
          #...........#.#
          ###.#.#####.#.#
          #...#.....#.#.#
          #.#.#.###.#.#.#
          #.....#...#.#.#
          #.###.#.#.#.#.#
          #S..#.....#...#
          ###############
        INPUT
      end

      def self.large_example_input
        <<-INPUT.strip
          #################
          #...#...#...#..E#
          #.#.#.#.#.#.#.#.#
          #.#.#.#...#...#.#
          #.#.#.#.###.#.#.#
          #...#.#.#.....#.#
          #.#.#.#.#.#####.#
          #.#...#.#.#.....#
          #.#.#####.#.###.#
          #.#.#.......#...#
          #.#.###.#####.###
          #.#.#...#.....#.#
          #.#.#.#####.###.#
          #.#.#.........#.#
          #.#.#.#########.#
          #S#.............#
          #################
        INPUT
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        grid = Helpers::Grid.new(input)
        start = grid.find_with_value('S')
        start_direction = Helpers::Grid::Directions::EAST
        finish = grid.find_with_value('E')

        {
          grid: grid,
          start: start,
          start_direction: start_direction,
          finish: finish,
        }
      end

      PointDirection = Struct.new(:point, :direction)

      def to_key(point, direction)
        "#{point.x},#{point.y}:#{direction}"
      end

      def find_cheapest_path(grid, start_position, start_direction, finish)
        next_to_explore = [PointDirection[start_position, start_direction]]
        seen = Set.new
        distances = {
          to_key(start_position, start_direction) => 0,
        }

        while next_to_explore.any?
          current = next_to_explore.shift
          next if seen.include?(current)
          seen << current
          current_distance = distances[to_key(current.point, current.direction)]
          # puts
          # puts
          # puts
          puts "now exploring #{to_key(current.point, current.direction)}, distance: #{current_distance}"
          if current.point == finish
            return current_distance
          end


          delta = Helpers::Grid::DIRECTION_TO_DELTA[current.direction]
          # puts current.direction.inspect
          # puts current.point.inspect
          step_forward = Helpers::Grid::Point[current.point.x + delta.x, current.point.y + delta.y]
          if grid.inside_grid(step_forward) && grid.points[step_forward.y][step_forward.x] != '#'
            distances[to_key(step_forward, current.direction)] = [distances.fetch(to_key(step_forward, current.direction), 10_000_000_000), current_distance + 1].min
            next_to_explore << PointDirection[step_forward, current.direction] unless seen.include?(PointDirection[step_forward, current.direction])
          end

          direction_clockwise = Helpers::Grid::Directions::ALL_DIRECT[(Helpers::Grid::Directions::ALL_DIRECT.index(current.direction) + 1) % Helpers::Grid::Directions::ALL_DIRECT.length]
          distances[to_key(current.point, direction_clockwise)] = [distances.fetch(to_key(current.point, direction_clockwise), 10_000_000_000), current_distance + 1000].min
          next_to_explore << PointDirection[current.point, direction_clockwise] unless seen.include?(PointDirection[current.point, direction_clockwise])

          direction_counterclockwise = Helpers::Grid::Directions::ALL_DIRECT[(Helpers::Grid::Directions::ALL_DIRECT.index(current.direction) - 1) % Helpers::Grid::Directions::ALL_DIRECT.length]
          distances[to_key(current.point, direction_counterclockwise)] = [distances.fetch(to_key(current.point, direction_counterclockwise), 10_000_000_000), current_distance + 1000].min
          next_to_explore << PointDirection[current.point, direction_counterclockwise] unless seen.include?(PointDirection[current.point, direction_counterclockwise])

          next_to_explore = next_to_explore.uniq.sort do |a, b|
            distances[to_key(a.point, a.direction)] <=> distances[to_key(b.point, b.direction)]
          end
          # puts
          # puts "Distances:"
          # distances.each do |point, distance|
          #   puts "to: " + point.inspect + ", distance: " + distance.inspect
          # end
          # puts
          # puts "Next to explore:"
          # next_to_explore.each do |point|
          #   puts "point: " + to_key(point.point, point.direction).inspect + ", direction: " + distances[to_key(point.point, point.direction)].inspect
          # end
        end

        false
      end

      def part_one(input)
        parsed = parse(input)

        grid = parsed.dig(:grid)
        start_position = parsed.dig(:start)
        start_direction = parsed.dig(:start_direction)
        finish = parsed.dig(:finish)

        find_cheapest_path(grid, start_position, start_direction, finish)
      end

      def part_two(input)
        parsed = parse(input)

        nil
      end
    end
  end
end
