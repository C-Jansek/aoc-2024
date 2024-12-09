require 'test_helper'

module Aoc
  module Year2024
    class Day09Test < Minitest::Test
      describe 'parsing' do
        it 'parses the input correctly into a storage block' do
          expected_storage = [0, -1, -1, 1, 1, 1, -1, -1, -1, -1, 2, 2, 2, 2, 2]
          assert_equal expected_storage, Day09.new.parse('12345')
        end

        describe 'with the example input' do
          it 'parses the input correctly into a storage block' do
            expected_storage = [0, 0, -1, -1, -1, 1, 1, 1, -1, -1, -1, 2, -1, -1, -1, 3, 3, 3, -1, 4, 4, -1, 5, 5, 5, 5, -1, 6, 6, 6, 6, -1, 7, 7, 7, -1, 8, 8, 8, 8, 9, 9]
            assert_equal expected_storage, Day09.new.parse(Day09.example_input)
          end
        end
      end

      describe 'compressing' do
        it 'knows to compress by moving the last element to the first empty space' do
          expected_compressed_storage = [0, 2, 2, 1, 1, 1, 2, 2, 2, -1, -1, -1, -1, -1, -1]
          assert_equal expected_compressed_storage, Day09.new.compress([0, -1, -1, 1, 1, 1, -1, -1, -1, -1, 2, 2, 2, 2, 2])
        end

        describe 'with the example input' do
          it 'knows to compress by moving the last element to the first empty space' do
            expected_compressed_storage = [0, 0, 9, 9, 8, 1, 1, 1, 8, 8, 8, 2, 7, 7, 7, 3, 3, 3, 6, 4, 4, 6, 5, 5, 5, 5, 6, 6, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
            assert_equal expected_compressed_storage, Day09.new.compress([0, 0, -1, -1, -1, 1, 1, 1, -1, -1, -1, 2, -1, -1, -1, 3, 3, 3, -1, 4, 4, -1, 5, 5, 5, 5, -1, 6, 6, 6, 6, -1, 7, 7, 7, -1, 8, 8, 8, 8, 9, 9])
          end
        end

        describe 'when compressing in blocks' do
          it 'knows to compress by moving the last element to the first empty space' do
            expected_compressed_storage = [0, 2, 2, 1, 1, 1, 2, 2, 2, -1, -1, -1, -1, -1, -1]
            assert_equal expected_compressed_storage, Day09.new.compress([0, -1, -1, 1, 1, 1, -1, -1, -1, -1, 2, 2, 2, 2, 2])
          end

          describe 'with the example input' do
            it 'knows to compress by moving the last element to the first empty space' do
              expected_compressed_storage = [0, 0, 9, 9, 2, 1, 1, 1, 7, 7, 7, -1, 4, 4, -1, 3, 3, 3, -1, -1, -1, -1, 5, 5, 5, 5, -1, 6, 6, 6, 6, -1, -1, -1, -1, -1, 8, 8, 8, 8, -1, -1]
              assert_equal expected_compressed_storage, Day09.new.compress_in_blocks([0, 0, -1, -1, -1, 1, 1, 1, -1, -1, -1, 2, -1, -1, -1, 3, 3, 3, -1, 4, 4, -1, 5, 5, 5, 5, -1, 6, 6, 6, 6, -1, 7, 7, 7, -1, 8, 8, 8, 8, 9, 9])
            end
          end
        end
      end

      describe 'checksum' do
        it 'knows the checksum as the index multiplied by the element' do
          assert_equal 1928, Day09.new.calculate_checksum('0099811188827773336446555566..............'.split('').map(&:to_i))
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day09.example_input
          assert_equal 1928, Day09.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day09.personal_input
          assert_equal 6519155389266, Day09.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day09.example_input
          assert_equal 2858, Day09.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day09.personal_input
          assert_equal 6547228115826, Day09.new.part_two(personal_input)
        end
      end
    end
  end
end
