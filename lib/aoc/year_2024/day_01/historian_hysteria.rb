module Aoc
  module Year2024
    class Day01
      def self.example_input
        <<-MSG.strip
           3   4
           4   3
           2   5
           1   3
           3   9
           3   3
        MSG
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        left_location_ids = []
        right_location_ids = []

        input.strip.lines.each do |row|
          left_location_id, right_location_id = row.strip.match(/(\d+)\s+(\d+)/)[1, 2].map(&:to_i)
          left_location_ids << left_location_id
          right_location_ids << right_location_id
        end

        [left_location_ids, right_location_ids]
      end

      def part_one(input)
        left_location_ids, right_location_ids = parse(input).map(&:sort)

        distances = left_location_ids.zip(right_location_ids).map do |left, right|
          (left - right).abs
        end

        distances.sum
      end

      def part_two(input)
        left_location_ids, right_location_ids = parse(input)

        similarity_scores_of_ids = {}

        left_location_ids.each do |location_id|
          next if similarity_scores_of_ids.key?(location_id)

          similarity_scores_of_ids[location_id] = location_id * right_location_ids.count(location_id)
        end

        left_location_ids.map do |location_id|
          similarity_scores_of_ids[location_id]
        end.sum
      end
    end
  end
end
