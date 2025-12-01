module Aoc
  module Year2025
    class Day1
      def self.example_input
        <<-INPUT.strip
          L68
          L30
          R48
          L5
          R60
          L55
          L1
          L99
          R14
          L82 
        INPUT
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        input.strip.split.map do |row|
          matches = row.match(/([LR])(\d*)/)
          direction, digits = matches[1], matches[2]

          if direction == 'L'
            -digits.to_i
          else
            digits.to_i
          end
        end
      end

      def part_one(input)
        steps = parse(input)
        current = 50

        steps.count do |step|
          current += step
          current = current % 100
          current == 0
        end
      end

      def part_two(input)
        steps = parse(input)
        current = 50

        steps.sum do |step|
          quotient, remainder = (current + step).divmod(100)

          zero_touches = if current == 0 && step.negative?
                           quotient.abs - 1
                         elsif step.negative? && (remainder == 0)
                           quotient.abs + 1
                         else
                           quotient.abs
                         end

          current = remainder
          zero_touches
        end
      end
    end
  end
end
