require 'spec_helper'
require 'game_of_life'

describe GameOfLife do
    let(:generator) { GameOfLife.new(start_matrix) }
    let(:next_generation_matrix) { generator.next.matrix }

    context 'any live cell with less then 2 live neighbours should be dead' do
        context '0 live neighbours' do
            let(:start_matrix) do
                [
                    ['.', '.', '.'],
                    ['.', '*', '.'],
                    ['.', '.', '.']
                ]
            end

            let(:end_matrix) do
                [
                    ['.', '.', '.'],
                    ['.', '.', '.'],
                    ['.', '.', '.']
                ]
            end

            it { expect(next_generation_matrix).to eq(end_matrix) }
        end

        context '1 live neighbours' do
            let(:start_matrix) do
                [
                    ['.', '.', '.'],
                    ['.', '*', '.'],
                    ['.', '*', '.']
                ]
            end

            let(:end_matrix) do
                [
                    ['.', '.', '.'],
                    ['.', '.', '.'],
                    ['.', '.', '.']
                ]
            end

            it { expect(next_generation_matrix).to eq(end_matrix) }
        end
    end

    context 'Any live cell with two or three live neighbors lives on to the next generation' do
        context '2 live neighbours' do
            let(:start_matrix) do
                [
                    ['*', '.', '.'],
                    ['.', '*', '.'],
                    ['.', '.', '*']
                ]
            end

            let(:end_matrix) do
                [
                    ['.', '.', '.'],
                    ['.', '*', '.'],
                    ['.', '.', '.']
                ]
            end

            it { expect(next_generation_matrix).to eq(end_matrix) }
        end

        context '3 live neighbours' do
            let(:start_matrix) do
                [
                    ['*', '.', '*'],
                    ['.', '*', '.'],
                    ['.', '*', '.']
                ]
            end

            let(:end_matrix) do
                [
                    ['.', '*', '.'],
                    ['*', '*', '*'],
                    ['.', '.', '.']
                ]
            end

            it { expect(next_generation_matrix).to eq(end_matrix) }
        end
    end

    context 'Any live cell with more than three live neighbors dies, as if by overcrowding.' do
        context '4 live neighbours' do
            let(:start_matrix) do
                [
                    ['*', '*', '*'],
                    ['.', '*', '.'],
                    ['.', '*', '.']
                ]
            end

            let(:end_matrix) do
                [
                    ['*', '*', '*'],
                    ['.', '.', '.'],
                    ['.', '.', '.']
                ]
            end

            it { expect(next_generation_matrix).to eq(end_matrix) }
        end
    end
    context '10 generation' do
        let(:generation_zero) do
'.........*
.*.*...*..
..........
..*.*....*
.*..*...*.
.........*
..........
.....*..*.
.*....*...
.....**...'
        end

        let(:generation_10th) do
'..........
...*......
..*.*.....
..*.*.....
...*......
..........
..........
..........
..........
..........'
        end

        let(:after_10th_generation) do
          generator = GameOfLife.parse(generation_zero)
          10.times { generator = generator.next }
          generator
        end

        it { expect(after_10th_generation.to_s).to eq(generation_10th)}
    end
end
