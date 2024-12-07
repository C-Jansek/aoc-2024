require 'test_helper'

module Aoc
  module Year2024
    class Day07Test < Minitest::Test
      describe 'parsing' do
        it 'parses the input correctly into answers and numbers' do
          expected_obstructions = [
            { answer: 190, numbers: [10, 19] },
            { answer: 3267, numbers: [81, 40, 27] },
            { answer: 83, numbers: [17, 5] },
            { answer: 156, numbers: [15, 6] },
            { answer: 7290, numbers: [6, 8, 6, 15] },
            { answer: 161011, numbers: [16, 10, 13] },
            { answer: 192, numbers: [17, 8, 14] },
            { answer: 21037, numbers: [9, 7, 18, 13] },
            { answer: 292, numbers: [11, 6, 16, 20] },
          ]

          assert_equal expected_obstructions, Day07.new.parse(Day07.example_input)
        end
      end

      describe '#answerable' do
        it 'knows if the answer can be made with the numbers' do
          assert Day07.answerable(190, [10, 19]) # 10 * 19 = 190
          assert Day07.answerable(3267, [81, 40, 27]) # 81 + 40 * 27 and 81 * 40 + 27
          refute Day07.answerable(83, [17, 5])
          refute Day07.answerable(156, [15, 6])
          refute Day07.answerable(7290, [6, 8, 6, 15])
          refute Day07.answerable(161011, [16, 10, 13])
          refute Day07.answerable(192, [17, 8, 14])
          refute Day07.answerable(21037, [9, 7, 18, 13])
          assert Day07.answerable(292, [11, 6, 16, 20]) # 11 + 6 * 16 + 20
        end

        describe 'when concatenation is allowed' do
          it 'knows if the answer can be made with the numbers' do
            assert Day07.answerable(190, [10, 19], true) # 10 * 19 = 190
            assert Day07.answerable(3267, [81, 40, 27], true) # 81 + 40 * 27 and 81 * 40 + 27
            refute Day07.answerable(83, [17, 5], true)
            assert Day07.answerable(156, [15, 6], true) # 15 _ 6 = 156
            assert Day07.answerable(7290, [6, 8, 6, 15], true) # 6 * 8 _ 6 * 15
            refute Day07.answerable(161011, [16, 10, 13], true)
            assert Day07.answerable(192, [17, 8, 14], true) # 17 _ 8 + 14
            refute Day07.answerable(21037, [9, 7, 18, 13], true)
            assert Day07.answerable(292, [11, 6, 16, 20], true) # 11 + 6 * 16 + 20
          end
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day07.example_input
          assert_equal 3749, Day07.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day07.personal_input
          assert_equal 1582598718861, Day07.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day07.example_input
          assert_equal 11387, Day07.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day07.personal_input
          assert_equal 165278151522644, Day07.new.part_two(personal_input)
        end
      end
    end
  end
end
