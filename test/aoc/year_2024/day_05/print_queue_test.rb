require 'test_helper'

module Aoc
  module Year2024
    class Day05Test < Minitest::Test
      describe 'parsing' do
        it 'parses the input correctly into page ordering rules' do
          expected_page_ordering_rules = [
            [47, 53],
            [97, 13],
            [97, 61],
            [97, 47],
            [75, 29],
            [61, 13],
            [75, 53],
            [29, 13],
            [97, 29],
            [53, 29],
            [61, 53],
            [97, 53],
            [61, 29],
            [47, 13],
            [75, 47],
            [97, 75],
            [47, 61],
            [75, 61],
            [47, 29],
            [75, 13],
            [53, 13]
          ]

          assert_equal expected_page_ordering_rules, Day05.new.parse(Day05.example_input).dig(:page_ordering_rules)
        end

        it 'parses the input correctly into updates' do
          expected_updates = [
            [75, 47, 61, 53, 29],
            [97, 61, 53, 29, 13],
            [75, 29, 13],
            [75, 97, 47, 61, 53],
            [61, 13, 29],
            [97, 13, 75, 29, 47]
          ]

          assert_equal expected_updates, Day05.new.parse(Day05.example_input).dig(:updates)
        end
      end

      describe '#update_ordered' do
        it 'knows wether an update is in the right order' do
          page_ordering_rules = Day05.new.parse(Day05.example_input).dig(:page_ordering_rules)

          assert Day05.new.update_ordered?([75, 47, 61, 53, 29], page_ordering_rules)
          assert Day05.new.update_ordered?([97, 61, 53, 29, 13], page_ordering_rules)
          assert Day05.new.update_ordered?([75, 29, 13], page_ordering_rules)
          refute Day05.new.update_ordered?([75, 97, 47, 61, 53], page_ordering_rules)
          refute Day05.new.update_ordered?([61, 13, 29], page_ordering_rules)
          refute Day05.new.update_ordered?([97, 13, 75, 29, 47], page_ordering_rules)
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day05.example_input
          assert_equal 143, Day05.new.part_one(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day05.personal_input
          assert_equal 6949, Day05.new.part_one(personal_input)
        end
      end

      describe '#order_update' do
        it 'knows how to put an update in order' do
          page_ordering_rules = Day05.new.parse(Day05.example_input).dig(:page_ordering_rules)

          assert_equal [97,75,47,61,53], Day05.new.order_update([75,97,47,61,53], page_ordering_rules)
          assert_equal [61,29,13], Day05.new.order_update([61,13,29], page_ordering_rules)
          assert_equal [97,75,47,29,13], Day05.new.order_update([97,13,75,29,47], page_ordering_rules)
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = Day05.example_input
          assert_equal 123, Day05.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day05.personal_input
          assert_equal 4145, Day05.new.part_two(personal_input)
        end
      end
    end
  end
end
