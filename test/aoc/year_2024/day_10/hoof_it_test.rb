require 'test_helper'

module Aoc
  module Year2024
    class Day10Test < Minitest::Test
      describe 'parsing' do
        it 'parses the input correctly into a storage block' do
          input = <<-INPUT
            0123
            1234
            8765
            9876
          INPUT
          expected_grid = [
            [0, 1, 2, 3],
            [1, 2, 3, 4],
            [8, 7, 6, 5],
            [9, 8, 7, 6],
          ]
          assert_equal expected_grid, Day10.new.parse(input)
        end

        describe 'with the example input' do
          it 'parses the input correctly into a storage block' do
            # expected_storage = '00...111...2...333.44.5555.6666.777.888899'
            # assert_equal expected_storage, Day10.new.parse(Day10.example_input)
          end
        end
      end

      describe '#get_neighbors' do
        it 'gets the neighbours of a tile' do
          grid = [
            [0, 1, 2, 3],
            [1, 2, 3, 4],
            [8, 7, 6, 5],
            [9, 8, 7, 6],
          ]
          expected_neighbours = [
            {
              value: 1,
              x: 1,
              y: 0
            },
            {
              value: 1,
              x: 0,
              y: 1
            },
          ]
          assert_equal expected_neighbours, Day10.new.get_neighbours(grid, 0, 0)

          expected_neighbours = [
            {
              value: 1,
              x: 1,
              y: 0
            },
            {
              value: 3,
              x: 2,
              y: 1
            },
            {
              value: 7,
              x: 1,
              y: 2
            },
            {
              value: 1,
              x: 0,
              y: 1
            },
          ]
          assert_equal expected_neighbours, Day10.new.get_neighbours(grid, 1, 1)
        end
      end

      describe '#get_neighbors' do
        it 'gets the neighbours of a tile' do
          grid = [
            [0, 1, 2, 3],
            [1, 2, 3, 4],
            [8, 7, 6, 5],
            [9, 8, 7, 6],
          ]
          expected_trailheads = [
            {
              value: 0,
              x: 0,
              y: 0
            },
          ]
          assert_equal expected_trailheads, Day10.new.get_trailheads(grid)

          grid = [
            [1,0,-1,-1,9,-1,-1],
            [2,-1,-1,-1,8,-1,-1],
            [3,-1,-1,-1,7,-1,-1],
            [4,5,6,7,6,5,4],
            [-1,-1,-1,8,-1,-1,3],
            [-1,-1,-1,9,-1,-1,2],
            [-1,-1,-1,-1,-1,0,1],
          ]
          expected_trailheads = [
            {
              value: 0,
              x: 1,
              y: 0
            },
            {
              value: 0,
              x: 5,
              y: 6
            },
          ]
          assert_equal expected_trailheads, Day10.new.get_trailheads(grid)
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day10.example_input
          assert_equal 36, Day10.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day10.personal_input
          assert_equal 582, Day10.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day10.example_input
          assert_equal 81, Day10.new.part_two(example_input)
        end

        it 'provides the correct answer for another example' do
          example_input = <<-INPUT
            012345
            123456
            234567
            345678
            4.6789
            56789.
          INPUT
          assert_equal 227, Day10.new.part_two(example_input)
        end


        it 'provides the correct answer for the personal input' do
          personal_input = Day10.personal_input
          assert_equal 1302, Day10.new.part_two(personal_input)
        end
      end
    end
  end
end
