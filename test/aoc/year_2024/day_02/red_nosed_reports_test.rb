require 'test_helper'

module Aoc
  module Year2024
    class Day02Test < Minitest::Test
      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day02.example_input
          assert_equal 2, Day02.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day02.personal_input
          assert_equal 479, Day02.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        describe 'dampened variations' do
          it 'shows all dampened variations with one level removed' do
            assert_equal [[0, 1, 2], [1, 2], [0, 2], [0, 1]], Day02.new.dampened_variations([0, 1, 2])
          end
        end

        it 'provides the correct answer for the example' do
          example_input = Day02.example_input
          assert_equal 4, Day02.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day02.personal_input
          assert_equal 531, Day02.new.part_two(personal_input)
        end
      end
    end
  end
end
