require 'test_helper'

module Aoc
  module Year2024
    class Day17Test < Minitest::Test
      describe 'parsing' do
        describe 'with the example input' do
          it 'parses the input correctly into a storage block' do
            expected_parsed = {
              registers: {
                a: 729,
                b: 0,
                c: 0,
              },
              program: [0, 1, 5, 4, 3, 0]
            }
            assert_equal expected_parsed, Day17.new.parse(Day17.example_input)
          end
        end
      end

      describe 'small programs' do
        it 'provides the correct answer' do
          # If register C contains 9, the program 2,6 would set register B to 1.
          input = <<-INPUT
            Register A: 0
            Register B: 0
            Register C: 9
  
            Program: 2,6
          INPUT
          assert_equal 1, Day17.new.part_one(input)[2]

          # If register A contains 10, the program 5,0,5,1,5,4 would output 0,1,2.
          input = <<-INPUT
            Register A: 10
            Register B: 0
            Register C: 0
  
            Program: 5,0,5,1,5,4
          INPUT
          assert_equal '0,1,2', Day17.new.part_one(input)[0]

          # If register A contains 2024, the program 0,1,5,4,3,0 would output 4,2,5,6,7,7,7,7,3,1,0 and leave 0 in register A.
          input = <<-INPUT
            Register A: 2024
            Register B: 0
            Register C: 0
  
            Program: 0,1,5,4,3,0
          INPUT
          assert_equal '4,2,5,6,7,7,7,7,3,1,0', Day17.new.part_one(input)[0]
          assert_equal 0, Day17.new.part_one(input)[1]

          # If register B contains 29, the program 1,7 would set register B to 26.
          input = <<-INPUT
            Register A: 0
            Register B: 29
            Register C: 0
  
            Program: 1,7 
          INPUT
          assert_equal 26, Day17.new.part_one(input)[2]

          # If register B contains 2024 and register C contains 43690, the program 4,0 would set register B to 44354.
          input = <<-INPUT
            Register A: 0
            Register B: 2024
            Register C: 43690
  
            Program: 4,0
          INPUT
          assert_equal 44354, Day17.new.part_one(input)[2]
        end
      end

      describe 'part one' do
        it 'provides the correct answer for the example' do
          example_input = Day17.example_input
          assert_equal '4,6,3,5,6,3,5,2,1,0', Day17.new.part_one(example_input)[0]
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day17.personal_input
          assert_equal '7,3,5,7,5,7,4,3,0', Day17.new.part_one(personal_input)[0]
        end
      end

      describe 'part two' do
        it 'provides the correct answer for the example' do
          example_input = <<-INPUT
            Register A: 2024
            Register B: 0
            Register C: 0
            
            Program: 0,3,5,4,3,0
          INPUT
          assert_equal 117440, Day17.new.part_two(example_input)
        end

        it 'provides the correct answer for the personal input' do
          personal_input = Day17.personal_input
          expected = Day17.new.parse(personal_input).dig(:program).map(&:to_s).join(',')
          # assert_equal expected, Day17.new.part_two(personal_input, overwrite_a: 230184372888831)
          # assert_equal expected, Day17.new.part_two(personal_input, overwrite_a: 105_964_372_088_832)
          # assert_equal expected, Day17.new.part_two(personal_input, overwrite_a: 106009656297623)
          # assert_equal expected, Day17.new.part_one(personal_input, overwrite_a: 106009656297627)[0]
          # assert_equal expected, Day17.new.part_one(personal_input)[0]

          # 106009656297627 TOO HIGH
          ans = Day17.new.part_two(personal_input)
          puts ans
          assert 106009656297627 > ans
          # 106009656297627
          # 105872213245252
          #
          # assert_equal expected, Day17.new.part_two(personal_input)

          # assert_equal expected, Day17.new.part_two(personal_input, overwrite_a: 35184372088832)
          # 109033313274266 TOO HIGH
          # 106009656297627 TOO HIGH
          # 105872213248410 WRONG
        end
      end
    end
  end
end
