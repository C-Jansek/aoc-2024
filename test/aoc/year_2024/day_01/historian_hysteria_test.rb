require 'test_helper'

module Aoc
  module Year2024
    class Day01Test < Minitest::Test
      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day01.example_input
          assert_equal 11, Day01.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day01.personal_input
          assert_equal 2430334, Day01.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day01.example_input
          assert_equal 11, Day01.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day01.personal_input
          assert_equal 28786472, Day01.new.part_two(personal_input)
        end
      end
    end
  end
end
