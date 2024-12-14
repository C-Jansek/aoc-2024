module Aoc
  module Year2024
    class Day14
      def self.example_input
        <<-INPUT.strip
          p=0,4 v=3,-3
          p=6,3 v=-1,-3
          p=10,3 v=-1,2
          p=2,0 v=2,-1
          p=0,0 v=1,3
          p=3,0 v=-2,-2
          p=7,6 v=-1,-3
          p=3,0 v=-1,-2
          p=9,3 v=2,3
          p=7,3 v=-1,2
          p=2,4 v=2,-3
          p=9,5 v=-3,-3
        INPUT
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      GUARD_PATTERN = /p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)/
      Guard = Struct.new(:position, :velocity)

      def parse(input)
        input.strip.lines.map do |line|
          position_x, position_y, velocity_x, velocity_y = line.strip.match(GUARD_PATTERN)[1..4].map(&:to_i)
          Guard.new([position_x, position_y], [velocity_x, velocity_y])
        end
      end

      def self.update_position(guard, width = 101, height = 103)
        new_x = (guard.position[0] + guard.velocity[0]) % width
        new_y = (guard.position[1] + guard.velocity[1]) % height
        guard.position = [new_x, new_y]
        guard
      end

      def self.group_by_quadrant(guards, width = 101, height = 103)
        guards.reject do |guard|
          guard.position[0] == (width - 1) / 2 || guard.position[1] == (height - 1) / 2
        end.group_by do |guard|
          [guard.position[0] > (width - 1) / 2, guard.position[1] > (height - 1) / 2]
        end
      end

      def part_one(input, example: false)
        guards = parse(input)
        width, height = if example
                          [11, 7]
                        else
                          [101, 103]
                        end

        100.times do
          guards = guards.map do |guard|
            Day14.update_position(guard, width, height)
          end
        end

        quadrants = Day14.group_by_quadrant(guards, width, height)
        quadrants.map do |quadrant, guards|
          puts quadrant.inspect
          puts guards.map(&:position).inspect
        end

        quadrants.values.map(&:count).reduce(&:*)
      end

      def self.print_layout(guards, width, height)
        guard_positions = Set.new(guards.map(&:position))
        output = ''
        height.times do |y|
          output += '.'
          width.times do |x|
            output += if guard_positions.include?([x, y])
                        '██'
                      else
                        '  '
                      end
          end
          output += '.'
          output += "\n"
        end
        puts output
      end

      def part_two(input, example: false)
        guards = parse(input)
        width, height = if example
                          [11, 7]
                        else
                          [101, 103]
                        end

        iteration = 0
        while guards.count != guards.uniq(&:position).count do
          guards = guards.map do |guard|
            Day14.update_position(guard, width, height)
          end
          iteration += 1
        end

        Day14.print_layout(guards, width, height)

        iteration
      end
    end
  end
end
