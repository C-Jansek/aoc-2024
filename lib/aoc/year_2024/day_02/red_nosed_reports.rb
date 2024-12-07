module Aoc
  module Year2024
    class Day02
      def self.example_input
        <<-MSG.strip
          7 6 4 2 1
          1 2 7 8 9
          9 7 6 2 1
          1 3 2 4 5
          8 6 4 4 1
          1 3 6 7 9
        MSG
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        input.strip.lines.map do |line|
          line.split(' ').map(&:to_i)
        end
      end

      def safe?
        -> (report) do
          differences = report.each_cons(2).map do |first, second|
            second - first
          end
          differences.all? { |diff| diff.between?(1, 3) } || differences.all? { |diff| diff.between?(-3, -1) }
        end
      end

      def part_one(input)
        reports = parse(input)

        reports.count(&safe?)
      end

      def dampened_variations(report)
        report.length.times.map do |index|
          report.values_at(0...index, (index + 1)..-1)
        end + [report]
      end

      def part_two(input)
        reports = parse(input)

        reports.count do |report|
          dampened_variations(report).any?(&safe?)
        end
      end
    end
  end
end
