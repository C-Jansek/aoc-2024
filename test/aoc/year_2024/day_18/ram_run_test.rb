require 'test_helper'

module Aoc
  module Year2024
    class Day18Test < Minitest::Test
      describe 'parsing' do
        describe 'with the example input' do
          it 'parses the input correctly into a storage block' do
            expected_parsed = [
              Helpers::Grid::Point[5, 4],
              Helpers::Grid::Point[4, 2],
              Helpers::Grid::Point[4, 5],
              Helpers::Grid::Point[3, 0],
              Helpers::Grid::Point[2, 1],
              Helpers::Grid::Point[6, 3],
              Helpers::Grid::Point[2, 4],
              Helpers::Grid::Point[1, 5],
              Helpers::Grid::Point[0, 6],
              Helpers::Grid::Point[3, 3],
              Helpers::Grid::Point[2, 6],
              Helpers::Grid::Point[5, 1],
              Helpers::Grid::Point[1, 2],
              Helpers::Grid::Point[5, 5],
              Helpers::Grid::Point[2, 5],
              Helpers::Grid::Point[6, 5],
              Helpers::Grid::Point[1, 4],
              Helpers::Grid::Point[0, 4],
              Helpers::Grid::Point[6, 4],
              Helpers::Grid::Point[1, 1],
              Helpers::Grid::Point[6, 1],
              Helpers::Grid::Point[1, 0],
              Helpers::Grid::Point[0, 5],
              Helpers::Grid::Point[1, 6],
              Helpers::Grid::Point[2, 0]
            ]
            assert_equal expected_parsed, Day18.new.parse(Day18.example_input)
          end
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day18.example_input
          assert_equal 22, Day18.new.part_one(example_input, example: true)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day18.personal_input
          assert_equal 404, Day18.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day18.example_input
          assert_equal '6,1', Day18.new.part_two(example_input, example: true)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day18.personal_input
          assert_equal -1, Day18.new.part_two(personal_input)
        end
      end
    end
  end
end
