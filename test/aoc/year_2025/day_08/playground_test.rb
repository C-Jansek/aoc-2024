require 'test_helper'

module Aoc
  module Year2025
    class Day08Test < Minitest::Test
      describe 'parsing' do
        describe 'with the example input' do
          it 'parses the input correctly into 3d points' do
            expected_parsed = [
              Day08::Point.new(162, 817, 812),
              Day08::Point.new(57, 618, 57),
              Day08::Point.new(906, 360, 560),
              Day08::Point.new(592, 479, 940),
              Day08::Point.new(352, 342, 300),
              Day08::Point.new(466, 668, 158),
              Day08::Point.new(542, 29, 236),
              Day08::Point.new(431, 825, 988),
              Day08::Point.new(739, 650, 466),
              Day08::Point.new(52, 470, 668),
              Day08::Point.new(216, 146, 977),
              Day08::Point.new(819, 987, 18),
              Day08::Point.new(117, 168, 530),
              Day08::Point.new(805, 96, 715),
              Day08::Point.new(346, 949, 466),
              Day08::Point.new(970, 615, 88),
              Day08::Point.new(941, 993, 340),
              Day08::Point.new(862, 61, 35),
              Day08::Point.new(984, 92, 344),
              Day08::Point.new(425, 690, 689)
            ]

            assert_equal expected_parsed, Day08.new.parse(Day08.example_input)
          end
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day08.example_input
          assert_equal 40, Day08.new.part_one(example_input, pairs: 10)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day08.personal_input
          assert_equal 57564, Day08.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day08.example_input
          assert_equal 25272, Day08.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day08.personal_input
          assert_equal 133296744, Day08.new.part_two(personal_input)
        end
      end
    end
  end
end
