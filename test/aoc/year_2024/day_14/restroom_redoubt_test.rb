require 'test_helper'

module Aoc
  module Year2024
    class Day14Test < Minitest::Test
      describe 'parsing' do
        describe 'with the example input' do
          it 'parses the input correctly into guards' do
            expected_guards = [
              Day14::Guard[position: [0, 4], velocity: [3, -3]],
              Day14::Guard[position: [6, 3], velocity: [-1, -3]],
              Day14::Guard[position: [10, 3], velocity: [-1, 2]],
              Day14::Guard[position: [2, 0], velocity: [2, -1]],
              Day14::Guard[position: [0, 0], velocity: [1, 3]],
              Day14::Guard[position: [3, 0], velocity: [-2, -2]],
              Day14::Guard[position: [7, 6], velocity: [-1, -3]],
              Day14::Guard[position: [3, 0], velocity: [-1, -2]],
              Day14::Guard[position: [9, 3], velocity: [2, 3]],
              Day14::Guard[position: [7, 3], velocity: [-1, 2]],
              Day14::Guard[position: [2, 4], velocity: [2, -3]],
              Day14::Guard[position: [9, 5], velocity: [-3, -3]],
            ]
            assert_equal expected_guards, Day14.new.parse(Day14.example_input)
          end
        end
      end

      describe 'updating position' do
        it 'knows to update the position each second while wrapping around the edges' do
          guard = Day14::Guard[position: [2,4], velocity: [2,-3]]
          width = 11
          height = 7

          guard = Day14.update_position(guard, width, height)
          assert_equal [4,1], guard.position

          guard = Day14.update_position(guard, width, height)
          assert_equal [6,5], guard.position

          guard = Day14.update_position(guard, width, height)
          assert_equal [8,2], guard.position

          guard = Day14.update_position(guard, width, height)
          assert_equal [10, 6], guard.position

          guard = Day14.update_position(guard, width, height)
          assert_equal [1,3], guard.position
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day14.example_input
          assert_equal 12, Day14.new.part_one(example_input, example: true)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day14.personal_input
          assert_equal 218619324, Day14.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day14.example_input
          assert_equal -1, Day14.new.part_two(example_input, example: true)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day14.personal_input
          assert_equal 6446, Day14.new.part_two(personal_input)
        end
      end
    end
  end
end
