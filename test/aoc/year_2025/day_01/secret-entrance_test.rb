require 'test_helper'

module Aoc
  module Year2025
    class Day1Test < Minitest::Test
      describe 'parsing' do
        describe 'with the example input' do
          it 'parses the input correctly into a storage block' do
            expected_parsed = [
              -68,
              -30,
              +48,
              -5,
              +60,
              -55,
              -1,
              -99,
              +14,
              -82
            ]
            assert_equal expected_parsed, Day1.new.parse(Day1.example_input)
          end
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day1.example_input
          assert_equal 3, Day1.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day1.personal_input
          assert_equal 1007, Day1.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day1.example_input
          assert_equal 6, Day1.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day1.personal_input
          assert_equal 5820, Day1.new.part_two(personal_input)
        end
      end
    end
  end
end
