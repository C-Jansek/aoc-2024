module Aoc
  module Year2025
    class Day06
      def self.example_input
        <<~INPUT.strip
          123 328  51 64 
           45 64  387 23 
            6 98  215 314
          *   +   *   +   
        INPUT
      end

      Expression = Data.define(:numbers, :operator)

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        input.strip.lines.map do |row|
          row.strip.split(/\s+/)
        end.transpose.map do |expression|
          Expression.new(expression.slice(0..-2).map(&:to_i), expression.last)
        end
      end

      def part_one(input)
        expressions = parse(input)

        expressions.sum do |expression|
          expression.numbers.reduce(&expression.operator.to_sym)
        end
      end

      def part_two(input)
        parsed = parse(input)

        nil
      end
    end
  end
end
