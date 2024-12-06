require 'test_helper'

module Aoc
  module Year2024
    class Day06Test < Minitest::Test
      describe 'parsing' do
        it 'parses the input correctly into obstructions' do
          expected_obstructions = Set.new([
            [4, 0],
            [9, 1],
            [2, 3],
            [7, 4],
            [1, 6],
            [8, 7],
            [0, 8],
            [6, 9],
          ])

          assert_equal expected_obstructions, Day06.new.parse(Day06.example_input).dig(:obstructions)
        end

        it 'parses the input correctly and finds the guard' do
          assert_equal [4, 6, true], Day06.new.parse(Day06.example_input).dig(:guard)
        end

        it 'parses the input correctly and finds the size of the map' do
          assert_equal [10, 10], Day06.new.parse(Day06.example_input).dig(:size)
        end
      end

      describe '.inside_map' do
        it 'knows if a position is inside the map' do
          assert Day06.inside_map([0, 0], 3, 5)
          assert Day06.inside_map([2, 2], 3, 5)
          assert Day06.inside_map([4, 2], 3, 5)
          assert Day06.inside_map([4, 0], 3, 5)
          refute Day06.inside_map([-1, 0], 3, 5)
          refute Day06.inside_map([0, -4], 3, 5)
          refute Day06.inside_map([5, 2], 3, 5)
          refute Day06.inside_map([2, 3], 3, 5)
          refute Day06.inside_map([6, 5], 3, 5)
        end
      end

      describe '.turn_right' do
        it 'knows which direction is 90 degrees to the right of the current direction' do
          assert_equal :west, Day06.turn_right(:north)
          assert_equal :south, Day06.turn_right(:west)
          assert_equal :east, Day06.turn_right(:south)
          assert_equal :north, Day06.turn_right(:east)
        end
      end

      describe '.all_positions_to_the_right' do
        describe 'when current direction is north' do
          it 'knows all positions to the right' do
            expected_positions = [
              [1, 0],
              [2, 0],
              [3, 0],
            ]
            assert_equal expected_positions, Day06.all_positions_to_the_right([0, 0], :north, 4, 4)
          end
        end

        describe 'when current direction is east' do
          it 'knows all positions to the right' do
            expected_positions = [
              [3, 4],
              [3, 3],
              [3, 2],
              [3, 1],
              [3, 0],
            ]
            assert_equal expected_positions, Day06.all_positions_to_the_right([3, 5], :east, 7, 5)
          end
        end

        describe 'when traveling along the edge of the map' do
          it 'knows there is no position to the right' do
            assert_empty Day06.all_positions_to_the_right([3, 5], :west, 4, 12)
          end
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day06.example_input
          assert_equal 41, Day06.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day06.personal_input
          assert_equal 5453, Day06.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day06.example_input
          assert_equal 6, Day06.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day06.personal_input
          # 1502 too low
          # 1514 too low
          # 2123 wrong
          # 4221 is too high
          assert_equal 2188, Day06.new.part_two(personal_input)
        end
      end
    end
  end
end
