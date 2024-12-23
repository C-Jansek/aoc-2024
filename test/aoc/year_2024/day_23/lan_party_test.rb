require 'test_helper'

module Aoc
  module Year2024
    class Day23Test < Minitest::Test
      describe 'parsing' do
        describe 'with the example input' do
          it 'parses the input correctly into a storage block' do
            expected_parsed = {
              "kh" => Set.new(%w[tc qp ub ta]),
              "tc" => Set.new(%w[kh wh td co]),
              "qp" => Set.new(%w[kh ub td wh]),
              "de" => Set.new(%w[cg co ta ka]),
              "cg" => Set.new(%w[de tb yn aq]),
              "ka" => Set.new(%w[co tb ta de]),
              "co" => Set.new(%w[ka ta de tc]),
              "yn" => Set.new(%w[aq cg wh td]),
              "aq" => Set.new(%w[yn vc cg wq]),
              "ub" => Set.new(%w[qp kh wq vc]),
              "tb" => Set.new(%w[cg ka wq vc]),
              "vc" => Set.new(%w[aq ub wq tb]),
              "wh" => Set.new(%w[tc td yn qp]),
              "ta" => Set.new(%w[co ka de kh]),
              "td" => Set.new(%w[tc wh qp yn]),
              "wq" => Set.new(%w[tb ub aq vc])
            }
            assert_equal expected_parsed, Day23.new.parse(Day23.example_input)
          end
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day23.example_input
          assert_equal 7, Day23.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day23.personal_input
          assert_equal 1151, Day23.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day23.example_input
          assert_equal -1, Day23.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day23.personal_input
          assert_equal -1, Day23.new.part_two(personal_input)
        end
      end
    end
  end
end
