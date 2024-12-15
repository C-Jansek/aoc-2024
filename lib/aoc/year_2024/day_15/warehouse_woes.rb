module Aoc
  module Year2024
    class Day15
      def self.example_input_small
        <<-INPUT.strip
          ########
          #..O.O.#
          ##@.O..#
          #...O..#
          #.#.O..#
          #...O..#
          #......#
          ########
          
          <^^>>>vv<v>>v<<
        INPUT
      end

      def self.example_input_large
        <<-INPUT.strip
          ##########
          #..O..O.O#
          #......O.#
          #.OO..O.O#
          #..O@..O.#
          #O#..O...#
          #O..O..O.#
          #.OO.O.OO#
          #....O...#
          ##########
          
          <vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^
          vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v
          ><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<
          <<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^
          ^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><
          ^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^
          >^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^
          <><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>
          ^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>
          v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^
        INPUT
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def self.gps_coordinate(point)
        point.x + 100 * point.y
      end

      Point = Helpers::Grid::Point

      class Warehouse
        attr_reader :walls, :width, :height, :double_wide
        attr_accessor :boxes, :robot

        def initialize(input, double_wide: false)
          @walls = Set.new
          @boxes = Set.new
          @height = input.strip.lines.length
          @width = input.strip.lines.first.strip.length * (double_wide ? 2 : 1)
          @double_wide = double_wide

          input.strip.lines.each_with_index do |line, y|
            line.strip.split('').each_with_index do |value, x|
              case value
              when '#'
                if double_wide
                  @walls << Point[x * 2, y]
                  @walls << Point[x * 2 + 1, y]
                else
                  @walls << Point[x, y]
                end
              when 'O'
                if double_wide
                  @boxes << Point[x * 2, y]
                else
                  @boxes << Point[x, y]
                end
              when '@'
                if double_wide
                  @robot = Point[x * 2, y]
                else
                  @robot = Point[x, y]
                end
              else
                next
              end
            end
          end

          print
        end

        def print
          output = ' ' + (0...width).map { |value| value.to_s.split('').last.to_s }.join('') + "\n"

          height.times do |y|
            output += y.to_s
            width.times do |x|
              if walls.include?(Point[x, y])
                output += '#'
                next
              end

              if boxes.include?(Point[x, y])
                output += if double_wide
                            '['
                          else
                            'O'
                          end
                next
              end

              if double_wide && boxes.include?(Point[x - 1, y])
                output += ']'
                next
              end

              if robot == Point[x, y]
                output += '@'
                next
              end

              output += '.'
            end
            output += "\n"
          end

          puts output
        end

        def perform_move(move)
          delta = Helpers::Grid::DIRECTION_TO_DELTA[move]
          next_positions = [Point[robot.x + delta.x, robot.y + delta.y]]

          boxes_to_move_in_direction = Set.new

          until next_positions.empty? do
            next_position = next_positions.pop

            if walls.include?(next_position)
              return
            end

            if boxes.include?(next_position)
              boxes_to_move_in_direction << next_position

              next_positions << Point[next_position.x + delta.x, next_position.y + delta.y] unless double_wide && move == Helpers::Grid::Directions::WEST
              next_positions << Point[next_position.x + delta.x + 1, next_position.y + delta.y] if double_wide && move != Helpers::Grid::Directions::EAST
            end

            if double_wide
              potential_box_side = next_position.clone.tap { |pos| pos.x -= 1 }
              if double_wide && boxes.include?(potential_box_side)
                boxes_to_move_in_direction << potential_box_side

                next_positions << Point[potential_box_side.x + delta.x, potential_box_side.y + delta.y] unless double_wide && move == Helpers::Grid::Directions::WEST
                next_positions << Point[potential_box_side.x + delta.x + 1, potential_box_side.y + delta.y] if double_wide && move != Helpers::Grid::Directions::EAST
              end
            end
          end

          robot.x += delta.x
          robot.y += delta.y

          new_boxes = []
          boxes_to_move_in_direction.each do |box|
            boxes.delete(box)
            new_boxes << Point[box.x + delta.x, box.y + delta.y]
          end

          new_boxes.each do |new_box|
            boxes << new_box
          end
        end
      end

      def parse(input, part_two: false)
        warehouse_input, moves_input = input.strip.split(/\n\s*\n/)

        warehouse = Warehouse.new(warehouse_input, double_wide: part_two)
        moves = moves_input.strip.split('').map do |move|
          case move
          when '^'
            Helpers::Grid::Directions::NORTH
          when '>'
            Helpers::Grid::Directions::WEST
          when 'v'
            Helpers::Grid::Directions::SOUTH
          when '<'
            Helpers::Grid::Directions::EAST
          else
            next
          end
        end.compact

        {
          warehouse: warehouse,
          moves: moves
        }
      end

      def solve(input, part_two: false)
        parsed = parse(input, part_two: part_two)

        warehouse = parsed.dig(:warehouse)
        moves = parsed.dig(:moves)

        moves.each do |move|
          warehouse.perform_move(move)
        end

        warehouse.boxes.map do |box|
          Day15.gps_coordinate(box)
        end.sum
      end

      def part_one(input)
        solve(input)
      end

      def part_two(input)
        solve(input, part_two: true)
      end
    end
  end
end
