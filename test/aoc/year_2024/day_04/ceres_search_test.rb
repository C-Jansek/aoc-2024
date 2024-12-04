require 'test_helper'

module Aoc
  module Year2024
    class Day04Test < Minitest::Test
      describe '#possible_words' do
        it 'returns all the possible words, starting at that position' do
          example_input = Day04.example_input_part_one

          expected_words = %w[MMMS MSXM MMAM]
          assert_equal expected_words, Day04.new.possible_words(Day04.new.parse(example_input), 0, 0)
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day04.example_input_part_one
          assert_equal 18, Day04.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day04.personal_input
          assert_equal 2545, Day04.new.part_one(personal_input)
        end
      end

      describe '#diagonal_words' do
        it 'returns the two words on the diagonal from a position' do
          example_input = Day04.example_input_part_one
          assert_equal [nil, nil], Day04.new.diagonal_words(Day04.new.parse(example_input), 0, 0)
          assert_equal [nil, nil], Day04.new.diagonal_words(Day04.new.parse(example_input), 0, 1)
          assert_equal %w[MSX ASM], Day04.new.diagonal_words(Day04.new.parse(example_input), 1, 1)
          assert_equal %w[MMA MMA], Day04.new.diagonal_words(Day04.new.parse(example_input), 1, 2)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day04.example_input_part_one
          assert_equal 9, Day04.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day04.personal_input
          assert_equal 1886, Day04.new.part_two(personal_input)
        end
      end
    end
  end
end
