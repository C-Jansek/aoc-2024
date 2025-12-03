require 'test_helper'

module Aoc
  module Year2025
    class Day03Test < Minitest::Test
      describe 'parsing' do
        describe 'with the example input' do
          it 'parses the input correctly into a storage block' do
            expected_parsed = [
              [9, 8, 7, 6, 5, 4, 3, 2, 1, 1, 1, 1, 1, 1, 1],
              [8, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9],
              [2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 7, 8],
              [8, 1, 8, 1, 8, 1, 9, 1, 1, 1, 1, 2, 1, 1, 1],
            ]
            assert_equal expected_parsed, Day03.new.parse(Day03.example_input)
          end
        end
      end

      describe 'find the biggest twelve digit integer' do
        it 'can find the biggest two digit integer' do
          assert_equal 987654321111, Day03.new.find_biggest_n_digit_integer([9, 8, 7, 6, 5, 4, 3, 2, 1, 1, 1, 1, 1, 1, 1], 12)
          assert_equal 811111111119, Day03.new.find_biggest_n_digit_integer([8, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9], 12)
          assert_equal 434234234278, Day03.new.find_biggest_n_digit_integer([2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 7, 8], 12)
          assert_equal 888911112111, Day03.new.find_biggest_n_digit_integer([8, 1, 8, 1, 8, 1, 9, 1, 1, 1, 1, 2, 1, 1, 1], 12)
        end
      end

      describe 'find the biggest two digit integer' do
        it 'can find the biggest two digit integer' do
          assert_equal 98, Day03.new.find_biggest_n_digit_integer([9, 8, 7, 6, 5, 4, 3, 2, 1, 1, 1, 1, 1, 1, 1], 2)
          assert_equal 89, Day03.new.find_biggest_n_digit_integer([8, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9], 2)
          assert_equal 78, Day03.new.find_biggest_n_digit_integer([2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 7, 8], 2)
          assert_equal 92, Day03.new.find_biggest_n_digit_integer([8, 1, 8, 1, 8, 1, 9, 1, 1, 1, 1, 2, 1, 1, 1], 2)
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day03.example_input
          assert_equal 357, Day03.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day03.personal_input
          assert_equal 16854, Day03.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day03.example_input
          assert_equal 3121910778619, Day03.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day03.personal_input
          assert_equal 167526011932478, Day03.new.part_two(personal_input)
        end
      end
    end
  end
end
