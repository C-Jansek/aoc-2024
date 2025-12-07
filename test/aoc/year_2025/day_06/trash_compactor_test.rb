require 'test_helper'

module Aoc
  module Year2025
    class Day06Test < Minitest::Test
      describe 'parsing' do
        describe 'for part one' do
          describe 'with the example input' do
            it 'parses the input correctly into expressions' do
              expected_parsed = [
                Day06::Expression.new([123, 45, 6], '*'),
                Day06::Expression.new([328, 64, 98], '+'),
                Day06::Expression.new([51, 387, 215], '*'),
                Day06::Expression.new([64, 23, 314], '+'),
              ]
              assert_equal expected_parsed, Day06.new.parse(Day06.example_input)
            end
          end
        end

        describe 'for part two' do
          it 'parses the input correctly into expressions' do
            expected_parsed = [
              Day06::Expression.new([4, 431, 623], '+'),
              Day06::Expression.new([175, 581, 32], '*'),
              Day06::Expression.new([8, 248, 369], '+'),
              Day06::Expression.new([356, 24, 1], '*'),
            ]
            assert_equal expected_parsed, Day06.new.parse(Day06.example_input, part_two: true)
          end
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day06.example_input
          assert_equal 4277556, Day06.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day06.personal_input
          assert_equal 4951502530386, Day06.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day06.example_input
          assert_equal 3263827, Day06.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day06.personal_input
          assert_equal 8486156119946, Day06.new.part_two(personal_input)
        end
      end
    end
  end
end
