module Aoc
  module Year2025
    class Day06
      def self.example_input
        <<-INPUT.strip
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

      def parse(input, part_two: false)
        if part_two
          reversed_lines = input.strip.split("\n").map do |row|
            row.split('').reverse
          end

          reversed_lines = ensure_lines_same_length(reversed_lines)

          separated_expressions = reversed_lines.transpose.map { it.join.strip }.join("\n").split("\n\n")

          separated_expressions.map do |expression|
            parts = expression.split("\n")
            operator = parts.last.chars.last
            Expression.new(parts.map(&:to_i), operator)
          end
        else
          input.strip.lines.map do |row|
            row.strip.split(/\s+/)
          end.transpose.map do |expression|
            Expression.new(expression.slice(0..-2).map(&:to_i), expression.last)
          end
        end
      end

      def ensure_lines_same_length(lines)
        max_length = lines.map(&:size).max
        lines.each do |line|
          (max_length - line.length).times do
            line.prepend(' ')
          end
        end
      end

      def part_one(input)
        expressions = parse(input)

        expressions.sum do |expression|
          expression.numbers.reduce(&expression.operator.to_sym)
        end
      end

      def part_two(input)
        expressions = parse(input, part_two: true)

        expressions.sum do |expression|
          expression.numbers.reduce(&expression.operator.to_sym)
        end
      end
    end
  end
end
