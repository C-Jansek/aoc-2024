module Aoc
  module Year2025
    class Day03
      def self.example_input
        <<-INPUT.strip
         987654321111111
811111111111119
234234234234278
818181911112111 
        INPUT
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        input.strip.lines.map do |line|
          line.strip.split('').map(&:to_i)
        end
      end

      def find_biggest_n_digit_integer(digits, n = 12)
        used_digits = []
        last_used_index = -1

        n.times.reverse_each do |still_required_digits|
          range_start = last_used_index + 1
          range_to_choose_from = digits.drop(range_start)
                                       .reverse.drop(still_required_digits).reverse
          used_digits << range_to_choose_from.max

          last_used_index = range_to_choose_from.index(used_digits.last) + range_start
        end

        used_digits.reverse_each.with_index.sum do |digit, index|
          digit * 10 ** index
        end
      end

      def part_one(input)
        banks = parse(input)
        banks.sum do |digits|
          find_biggest_n_digit_integer(digits, 2)
        end
      end

      def part_two(input)
        banks = parse(input)
        banks.sum do |digits|
          find_biggest_n_digit_integer(digits, 12)
        end
      end
    end
  end
end
