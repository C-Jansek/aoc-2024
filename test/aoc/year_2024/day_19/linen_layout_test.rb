require 'test_helper'

module Aoc
  module Year2024
    class Day19Test < Minitest::Test
      describe 'parsing' do
        describe 'with the example input' do
          it 'parses the input correctly into towels and stacks' do
            expected_towels = %w[r wr b g bwu rb gb br]
            expected_stacks = %w[brwrr bggr gbbr rrbgbr ubwu bwurrg brgr bbrgwb]

            assert_equal expected_towels, Day19.new.parse(Day19.example_input).fetch(:towels)
            assert_equal expected_stacks, Day19.new.parse(Day19.example_input).fetch(:stacks)
          end
        end
      end

      describe 'stack possible' do
        it 'knows which stacks are possible' do
          towels = %w[r wr b g bwu rb gb br]

          assert Day19.stack_possible('brwrr', towels)
          assert Day19.stack_possible('bggr', towels)
          assert Day19.stack_possible('gbbr', towels)
          assert Day19.stack_possible('rrbgbr', towels)
          refute Day19.stack_possible('ubwu', towels)
          assert Day19.stack_possible('bwurrg', towels)
          assert Day19.stack_possible('brgr', towels)
          refute Day19.stack_possible('bbrgwb', towels)
        end

        it 'knows in how many ways stacks are possible' do
          towels = %w[r wr b g bwu rb gb br]

          assert_equal 2, Day19.stack_possible('brwrr', towels, count: true)
          assert_equal 1, Day19.stack_possible('bggr', towels, count: true)
          assert_equal 4, Day19.stack_possible('gbbr', towels, count: true)
          assert_equal 6, Day19.stack_possible('rrbgbr', towels, count: true)
          assert_equal 0, Day19.stack_possible('ubwu', towels, count: true)
          assert_equal 1, Day19.stack_possible('bwurrg', towels, count: true)
          assert_equal 2, Day19.stack_possible('brgr', towels, count: true)
          assert_equal 0, Day19.stack_possible('bbrgwb', towels, count: true)
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day19.example_input
          assert_equal 6, Day19.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day19.personal_input
          assert_equal 269, Day19.new.part_one(personal_input)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day19.example_input
          assert_equal 16, Day19.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day19.personal_input
          assert_equal 758839075658876, Day19.new.part_two(personal_input)
        end
      end
    end
  end
end
