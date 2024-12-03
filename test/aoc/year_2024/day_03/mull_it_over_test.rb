require 'test_helper'

module Aoc
  module Year2024
    class Day03Test < Minitest::Test
      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day03.example_input_part_one
          assert_equal 161, Day03.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day03.personal_input
          assert_equal 179571322, Day03.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day03.example_input_part_two
          assert_equal 48, Day03.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day03.personal_input
          assert_equal 103811193, Day03.new.part_two(personal_input)
        end
      end
    end
  end
end
