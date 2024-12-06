module Aoc
  module Year2024
    class Day06
      def self.example_input
        <<-MSG.strip
          ....#.....
          .........#
          ..........
          ..#.......
          .......#..
          ..........
          .#..^.....
          ........#.
          #.........
          ......#...
        MSG
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        obstructions = input.strip.lines.map.with_index do |line, y|
          line.strip.split('').map.with_index do |character, x|
            next [x, y] if character == '#'
            [x, y, true] if character == '^'
          end.reject(&:nil?)
        end.flatten(1).compact

        guard = obstructions.find do |coordinates|
          coordinates.fetch(2, nil)
        end

        obstructions.delete(guard)

        {
          obstructions: obstructions,
          guard: guard,
          size: [input.strip.lines[0].strip.length, input.strip.lines.length]
        }
      end

      DIRECTIONS = {
        north: [0, -1],
        west: [1, 0],
        south: [0, 1],
        east: [-1, 0],
      }

      DIRECTIONS_ORDER = %i[north west south east]

      def self.inside_map(position, map_height, map_width)
        position[0].between?(0, map_width - 1) && position[1].between?(0, map_height - 1)
      end

      def self.turn_right(current_direction)
        current_index = DIRECTIONS_ORDER.index(current_direction)
        next_index = (current_index + 1) % DIRECTIONS_ORDER.length

        DIRECTIONS_ORDER[next_index]
      end

      def self.all_positions_to_the_right(position, current_direction, map_height, map_width)
        positions = []
        direction = Day06.turn_right(current_direction)
        position = [position[0] + DIRECTIONS[direction][0],
                    position[1] + DIRECTIONS[direction][1]]

        while Day06.inside_map(position, map_height, map_width) do
          positions << position

          position = [
            position[0] + DIRECTIONS[direction][0],
            position[1] + DIRECTIONS[direction][1]
          ]
        end

        positions
      end

      def self.print_map(guard_position, guard_direction, obstructions, width, height, visited_positions)
        output = "\n"
        height.times do |y|
          width.times do |x|
            if guard_position == [x, y]
              case guard_direction
              when :north
                output += '^'
              when :west
                output += '>'
              when :south
                output += 'V'
              when :east
                output += '<'
              else
                raise StandardError
              end
              next
            end

            if obstructions.include?([x, y])
              output += '#'
            elsif visited_positions.include?([x, y])
              output += 'X'
            else
              output += '.'
            end
          end

          output += "\n"
        end

        puts output
      end

      def part_one(input)
        parsed = parse(input)

        guard_position = parsed.dig(:guard)[0..1]
        guard_direction = DIRECTIONS_ORDER[0]
        obstructions = parsed.dig(:obstructions)
        width, height = parsed.dig(:size)

        visited_positions = Set.new

        while Day06.inside_map(guard_position, width, height) do
          in_front = [
            guard_position[0] + DIRECTIONS[guard_direction][0],
            guard_position[1] + DIRECTIONS[guard_direction][1]
          ]

          if obstructions.include?(in_front)
            guard_direction = Day06.turn_right(guard_direction)
            in_front = [
              guard_position[0] + DIRECTIONS[guard_direction][0],
              guard_position[1] + DIRECTIONS[guard_direction][1]
            ]
          end

          visited_positions << guard_position
          guard_position = in_front
        end

        visited_positions.size
      end

      def in_front(position, direction)
        [
          position[0] + DIRECTIONS[direction][0],
          position[1] + DIRECTIONS[direction][1]
        ]
      end

      def walk_path(guard_position, guard_direction, obstructions, width, height)
        visited_positions = Set.new

        while Day06.inside_map(guard_position, width, height) do
          position_in_front = in_front(guard_position, guard_direction)

          while obstructions.include?(position_in_front)
            guard_direction = Day06.turn_right(guard_direction)
            position_in_front = in_front(guard_position, guard_direction)
          end

          if visited_positions.include?(guard_position + [guard_direction])
            return true
          end

          visited_positions << guard_position + [guard_direction]
          guard_position = position_in_front
        end

        visited_positions
      end

      def part_two(input)
        parsed = parse(input)

        guard_position = parsed.dig(:guard)[0..1]
        guard_direction = DIRECTIONS_ORDER[0]
        parsed_obstructions = parsed.dig(:obstructions)
        obstructions = Set.new
        parsed_obstructions.each do |obstruction|
          obstructions << obstruction
        end

        width, height = parsed.dig(:size)

        visited_positions = walk_path(guard_position, guard_direction, obstructions, width, height)

        looped = 0
        visited_positions.uniq do |potential|
          potential[0..1]
        end.each do |potential|
          next if potential[0..1] == guard_position

          result = walk_path(guard_position, guard_direction, obstructions + [potential[0..1]], width, height)
          if result == true
            looped += 1
            puts "looped: #{looped}" if looped % 100 == 0
          end
        end

        looped
      end
    end
  end
end
