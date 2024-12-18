module Aoc
  module Year2024
    class Day18
      def self.example_input
        <<-INPUT.strip
          5,4
          4,2
          4,5
          3,0
          2,1
          6,3
          2,4
          1,5
          0,6
          3,3
          2,6
          5,1
          1,2
          5,5
          2,5
          6,5
          1,4
          0,4
          6,4
          1,1
          6,1
          1,0
          0,5
          1,6
          2,0
        INPUT
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        input.strip.lines.map do |line|
          Helpers::Grid::Point[*line.strip.match(/(\d+),(\d+)/)[1..2].map(&:to_i)]
        end
      end

      def part_one(input, example: false)
        falling_bytes = parse(input)
        size = example ? 7 : 71

        points = size.times.map do |y|
          size.times.map do |x|
            if falling_bytes.first(example ? 12 : 1024).include?(Helpers::Grid::Point[x, y])
              '#'
            else
              '.'
            end
          end
        end

        next_to_explore = [Helpers::Grid::Point[0, 0]]
        finish = Helpers::Grid::Point[size - 1, size - 1]
        seen = Set.new
        distances = {
          Helpers::Grid::Point[0, 0] => 0,
        }

        while next_to_explore.any?
          # puts next_to_explore.map { |point| [point.x, point.y] }.inspect
          current = next_to_explore.shift
          next if seen.include?(current)

          seen << current
          current_distance = distances[current]

          #           puts "distances: #{distances.inspect}"

          puts current.inspect
          if current == finish
            return current_distance
          end

          Helpers::Grid::Directions::ALL_DIRECT.each do |direction|
            delta = Helpers::Grid::DIRECTION_TO_DELTA[direction]
            neighbour = Helpers::Grid::Point[current.x + delta.x, current.y + delta.y]

            if neighbour.x.between?(0, size - 1) && neighbour.y.between?(0, size - 1)
              next if points[neighbour.y][neighbour.x] == '#'

              distance = current_distance + 1
              next_to_explore << neighbour
              distances[neighbour] = [distances.fetch(neighbour, 10_000), distance].min
            end
          end

          next_to_explore = next_to_explore.uniq.sort do |a, b|
            distances[a] <=> distances[b]
          end
        end

        false
      end

      def solve(input, fallen_bytes_count, example: false)
        falling_bytes = parse(input)
        size = example ? 7 : 71

        points = size.times.map do |y|
          size.times.map do |x|
            if falling_bytes.first(fallen_bytes_count).include?(Helpers::Grid::Point[x, y])
              '#'
            else
              '.'
            end
          end
        end

        next_to_explore = [Helpers::Grid::Point[0, 0]]
        finish = Helpers::Grid::Point[size - 1, size - 1]
        seen = Set.new
        distances = {
          Helpers::Grid::Point[0, 0] => 0,
        }

        while next_to_explore.any?
          # puts next_to_explore.map { |point| [point.x, point.y] }.inspect
          current = next_to_explore.shift
          next if seen.include?(current)

          seen << current
          current_distance = distances[current]

          if current == finish
            return current_distance
          end

          Helpers::Grid::Directions::ALL_DIRECT.each do |direction|
            delta = Helpers::Grid::DIRECTION_TO_DELTA[direction]
            neighbour = Helpers::Grid::Point[current.x + delta.x, current.y + delta.y]

            if neighbour.x.between?(0, size - 1) && neighbour.y.between?(0, size - 1)
              next if points[neighbour.y][neighbour.x] == '#'

              distance = current_distance + 1
              next_to_explore << neighbour
              distances[neighbour] = [distances.fetch(neighbour, 10_000), distance].min
            end
          end

          next_to_explore = next_to_explore.uniq.sort do |a, b|
            distances[a] <=> distances[b]
          end
        end

        false
      end

      def part_two(input, example: false)
        parsed = parse(input)

        higher = parsed.count
        lower = 0

        while true
          guess = ((higher + lower) / 2)
          ans = solve(input, guess, example: example)

          puts "lower: #{lower}, guess: #{guess}, higher: #{higher}, ans: #{ans}"
          if higher - guess == 1
            first_wrong = parsed[guess]
            return "#{first_wrong.x},#{first_wrong.y}"
          end

          if ans == false
            higher = guess
          else
            lower = guess
          end
        end

        false
      end
    end
  end
end
