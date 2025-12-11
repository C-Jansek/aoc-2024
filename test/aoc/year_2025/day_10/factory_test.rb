require 'test_helper'

module Aoc
  module Year2025
    class Day10Test < Minitest::Test
      describe 'parsing' do
        describe 'with the example input' do
          it 'parses the input correctly into a storage block' do
            expected_parsed = [
              Day10::Machine.new([false, true, true, false], [[3], [1, 3], [2], [2, 3], [0, 2], [0, 1]], [3, 5, 4, 7]),
              Day10::Machine.new([false, false, false, true, false], [[0, 2, 3, 4], [2, 3], [0, 4], [0, 1, 2], [1, 2, 3, 4]], [7, 5, 12, 7, 2]),
              Day10::Machine.new([false, true, true, true, false, true], [[0, 1, 2, 3, 4], [0, 3, 4], [0, 1, 2, 4, 5], [1, 2]], [10, 11, 11, 5, 10, 5]),
            ]

            assert_equal expected_parsed, Day10.new.parse(Day10.example_input)
          end
        end
      end

      describe 'button presses required for indicator lights' do
        it 'knows what the minimum amount of button presses required is' do
          assert_equal 2, Day10.indicator_lights_button_presses_required(Day10::Machine.new([false, true, true, false], [[3], [1, 3], [2], [2, 3], [0, 2], [0, 1]], [3, 5, 4, 7]))
          assert_equal 3, Day10.indicator_lights_button_presses_required(Day10::Machine.new([false, false, false, true, false], [[0, 2, 3, 4], [2, 3], [0, 4], [0, 1, 2], [1, 2, 3, 4]], [7, 5, 12, 7, 2]))
          assert_equal 2, Day10.indicator_lights_button_presses_required(Day10::Machine.new([false, true, true, true, false, true], [[0, 1, 2, 3, 4], [0, 3, 4], [0, 1, 2, 4, 5], [1, 2]], [10, 11, 11, 5, 10, 5]))
        end
      end

      describe 'button presses required for joltage levels' do
        it 'knows what the minimum amount of button presses required is' do
          assert_equal 10, Day10.joltage_button_presses_required(Day10::Machine.new([false, true, true, false], [[3], [1, 3], [2], [2, 3], [0, 2], [0, 1]], [3, 5, 4, 7]))
          assert_equal 12, Day10.joltage_button_presses_required(Day10::Machine.new([false, false, false, true, false], [[0, 2, 3, 4], [2, 3], [0, 4], [0, 1, 2], [1, 2, 3, 4]], [7, 5, 12, 7, 2]))
          assert_equal 11, Day10.joltage_button_presses_required(Day10::Machine.new([false, true, true, true, false, true], [[0, 1, 2, 3, 4], [0, 3, 4], [0, 1, 2, 4, 5], [1, 2]], [10, 11, 11, 5, 10, 5]))
          assert_equal 20, Day10.joltage_button_presses_required(Day10::Machine.new([false, true, true, false], [[3], [1, 3], [2], [2, 3], [0, 2], [0, 1]], [6, 10, 8, 14]))
        end
      end

      describe 'distance left' do
        it 'knows how much distance is left' do
          assert_equal 0, Day10.distance_left([0, 0, 0, 0], [0, 0, 0, 0])
          assert_equal 0, Day10.distance_left([1, 0, 0, 0], [1, 0, 0, 0])
          assert_equal 1, Day10.distance_left([0, 0, 0, 0], [1, 0, 0, 0])
          refute_equal Day10.distance_left([1, 0, 1, 0], [3, 5, 4, 7]), Day10.distance_left([0, 0, 1, 1], [3, 5, 4, 7])
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day10.example_input
          assert_equal 7, Day10.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day10.personal_input
          assert_equal 535, Day10.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day10.example_input
          assert_equal 33, Day10.new.part_two(example_input)
        end

        it 'provides the correct answer for one of the personal input rows' do
          input = "[.#.#....] (0,1,2,3,5,6,7) (0,1,2,6,7) (3) (0,5,6) (3,7) (0,2,3,5,7) (0,1,5,7) (1,3,4) (0,2,3,5,6) {86,57,60,72,9,70,49,74}"
          assert_equal -1, Day10.new.part_two(input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day10.personal_input
          assert_equal -1, Day10.new.part_two(personal_input)
        end
      end
    end
  end
end
