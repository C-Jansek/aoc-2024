module Aoc
  module Year2025
    class Day07
      def self.example_input
        <<~INPUT.strip
          .......S.......
          ...............
          .......^.......
          ...............
          ......^.^......
          ...............
          .....^.^.^.....
          ...............
          ....^.^...^....
          ...............
          ...^.^...^.^...
          ...............
          ..^...^.....^..
          ...............
          .^.^.^.^.^...^.
          ............... 
        INPUT
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        Helpers::Grid.new(input.strip)
      end

      def part_one(input)
        grid = parse(input)

        active_beams = [grid.points.first.index('S')]
        total_splits = 0
        grid.points.drop(1).each do |row|
          active_beams = active_beams.flat_map do |beam_index|
            next [beam_index] unless row[beam_index] == '^'

            total_splits += 1
            [beam_index - 1, beam_index + 1]
          end.uniq
        end

        total_splits
      end

      def part_two(input)
        grid = parse(input)

        active_beams = { grid.points.first.index('S') => 1 }
        grid.points.drop(1).each do |row|
          active_beams = active_beams.each_with_object({}) do |beam, new_beams|
            beam_index, count = beam
            next new_beams[beam_index] = new_beams.fetch(beam_index, 0) + count unless row[beam_index] == '^'

            new_beams[beam_index - 1] = new_beams.fetch(beam_index - 1, 0) + count unless beam_index < 0
            new_beams[beam_index + 1] = new_beams.fetch(beam_index + 1, 0) + count unless beam_index >= grid.width
          end
        end

        active_beams.values.sum
      end
    end
  end
end
