module Aoc
  module Year2025
    class Day02
      def self.example_input
        <<-INPUT.strip
         11-22,95-115,998-1012,1188511880-1188511890,222220-222224,
1698522-1698528,446443-446449,38593856-38593862,565653-565659,
824824821-824824827,2121212118-2121212124 
        INPUT
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        input.strip.split(',').map do |range|
          range.split('-').map(&:to_i)
        end
      end

      def find_double_ids(range)
        start = range.first
        stop = range.last

        (start..stop).filter do |id|
          string = id.to_s
          next false if string.size % 2 != 0

          string[0...(string.size / 2)] == string[(string.size / 2)..-1]
        end
      end

      def find_multiplied_ids(range)
        start = range.first
        stop = range.last

        (start..stop).filter do |id|
          string = id.to_s
          possible_groupings = (1..string.size / 2).filter do |possible_size|
            string.size % possible_size == 0
          end

          digits = string.split('')
          possible_groupings.any? do |possible_grouping|
            slices = digits.each_slice(possible_grouping)
            slices.all? { it == slices.first }
          end
        end
      end

      def part_one(input)
        ranges = parse(input)
        ranges.flat_map { find_double_ids(it) }.sum
      end

      def part_two(input)
        ranges = parse(input)
        ranges.flat_map { find_multiplied_ids(it) }.sum
      end
    end
  end
end
