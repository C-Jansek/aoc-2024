require 'test_helper'

module Aoc
  module Year2025
    class Day02Test < Minitest::Test
      describe 'parsing' do
        describe 'with the example input' do
          it 'parses the input correctly into a storage block' do
            expected_parsed = [
              [11, 22],
              [95, 115],
              [998, 1012],
              [1188511880, 1188511890],
              [222220, 222224],
              [1698522, 1698528],
              [446443, 446449],
              [38593856, 38593862],
              [565653, 565659],
              [824824821, 824824827],
              [2121212118, 2121212124]
            ]
            assert_equal expected_parsed, Day02.new.parse(Day02.example_input)
          end
        end
      end

      describe 'find invalid ids' do
        it 'can find double ids' do
          assert_equal [11, 22], Day02.new.find_double_ids([11, 22])
          assert_equal [99], Day02.new.find_double_ids([95,115])
          assert_equal [1010], Day02.new.find_double_ids([998,1012])
          assert_equal [1188511885], Day02.new.find_double_ids([1188511880,1188511890])
          assert_equal [222222], Day02.new.find_double_ids([222220,222224])
          assert_equal [], Day02.new.find_double_ids([1698522,1698528])
        end

        it 'can find multiplied ids' do
          assert_equal [11, 22], Day02.new.find_multiplied_ids([11, 22])
          assert_equal [99, 111], Day02.new.find_multiplied_ids([95,115])
          assert_equal [999, 1010], Day02.new.find_multiplied_ids([998,1012])
          assert_equal [1188511885], Day02.new.find_multiplied_ids([1188511880,1188511890])
          assert_equal [222222], Day02.new.find_multiplied_ids([222220,222224])
          assert_equal [], Day02.new.find_multiplied_ids([1698522,1698528])
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day02.example_input
          assert_equal 1227775554, Day02.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day02.personal_input
          assert_equal 5398419778, Day02.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day02.example_input
          assert_equal 4174379265, Day02.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day02.personal_input
          assert_equal 15704845910, Day02.new.part_two(personal_input)
        end
      end
    end
  end
end
