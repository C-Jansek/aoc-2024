require 'test_helper'

module Aoc
  module Year2025
    class Day07Test < Minitest::Test
      describe 'parsing' do
        describe 'with the example input' do
          it 'parses the input into a grid' do
            assert_equal Helpers::Grid.to_s, Day07.new.parse(Day07.example_input).class.name
          end
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day07.example_input
          assert_equal 21, Day07.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day07.personal_input
          assert_equal 1490, Day07.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day07.example_input
          assert_equal 40, Day07.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day07.personal_input
          assert_equal 3806264447357, Day07.new.part_two(personal_input)
        end
      end
    end
  end
end
