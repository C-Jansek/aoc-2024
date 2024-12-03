module Aoc
  module Year2024
    class Day03
      def self.example_input_part_one
        <<-MSG.strip
          xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
        MSG
      end
      def self.example_input_part_two
        <<-MSG.strip
          xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
        MSG
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        input.strip
      end

      MULTIPLICATION_REGEX = /mul\((\d{1,3}),(\d{1,3})\)/
      def part_one(input)
        parse(input).scan(MULTIPLICATION_REGEX).map do |first, second|
          first.to_i * second.to_i
        end.sum
      end

      COMMANDS_REGEX = /mul\((\d{1,3}),(\d{1,3})\)|(do\(\))|(don't\(\))/
      def part_two(input)
        instructions_enabled = true

        parse(input).scan(COMMANDS_REGEX).sum do |result|
          if result.include? "do()"
            instructions_enabled = true
          elsif result.include? "don't()"
            instructions_enabled = false
          elsif instructions_enabled
            next result[0].to_i * result[1].to_i
          end

          next 0
        end
      end
    end
  end
end
