require 'test_helper'

module Aoc
  module Helpers
    class GridTest < Minitest::Test
      input = <<-INPUT
        0123
        1234
        8765
        9876
      INPUT

      describe 'parsing' do
        it 'parses the input correctly into a grid' do
          expected_grid = [
            [0, 1, 2, 3],
            [1, 2, 3, 4],
            [8, 7, 6, 5],
            [9, 8, 7, 6],
          ]
          assert_equal expected_grid, Grid.new(input, parsing_mode: Grid::ParsingModes::DIGIT).points
        end

        describe 'with parsing mode CHARACTER' do
          it 'parses the input correctly into a grid' do
            expected_grid = [
              %w[0 1 2 3],
              %w[1 2 3 4],
              %w[8 7 6 5],
              %w[9 8 7 6],
            ]
            assert_equal expected_grid, Grid.new(input, parsing_mode: Grid::ParsingModes::CHARACTER).points
          end
        end
      end

      describe '#get_neighbors' do
        it 'gets the neighbours of a point' do
          grid = Grid.new(input)
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
          assert_equal expected_neighbours, grid.get_neighbours(0, 0)

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
          assert_equal expected_neighbours, grid.get_neighbours(1, 1)
        end
      end
    end
  end
end
