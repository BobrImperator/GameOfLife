require 'spec_helper'
require 'next_generation'

describe NextGeneration do
    let(:generator) { NextGeneration.new(start_matrix) }
    let(:next_generation_matrix) { generator.next.matrix }

    context 'any live cell with less then 2 live neighbours should be dead' do
        context '0 live neighbours' do
            let(:start_matrix) do
                [
                    [0, 0, 0],
                    [0, 1, 0],
                    [0, 0, 0]
                ]
            end

            let(:end_matrix) do
                [
                    [0, 0, 0],
                    [0, 0, 0],
                    [0, 0, 0]
                ]
            end

            it { expect(next_generation_matrix).to eq(end_matrix) }
        end

        context '1 live neighbours' do
            let(:start_matrix) do
                [
                    [0, 0, 0],
                    [0, 1, 0],
                    [0, 1, 0]
                ]
            end

            let(:end_matrix) do
                [
                    [0, 0, 0],
                    [0, 0, 0],
                    [0, 0, 0]
                ]
            end

            it { expect(next_generation_matrix).to eq(end_matrix) }
        end
    end

    context 'Any live cell with two or three live neighbors lives on to the next generation' do
        context '2 live neighbours' do
            let(:start_matrix) do
                [
                    [1, 0, 0],
                    [0, 1, 0],
                    [0, 0, 1]
                ]
            end

            let(:end_matrix) do
                [
                    [0, 0, 0],
                    [0, 1, 0],
                    [0, 0, 0]
                ]
            end

            it { expect(next_generation_matrix).to eq(end_matrix) }
        end

        context '3 live neighbours' do
            let(:start_matrix) do
                [
                    [1, 0, 1],
                    [0, 1, 0],
                    [0, 1, 0]
                ]
            end

            let(:end_matrix) do
                [
                    [0, 1, 0],
                    [1, 1, 1],
                    [0, 0, 0]
                ]
            end

            it { expect(next_generation_matrix).to eq(end_matrix) }
        end
    end

    context "Any live cell with more than three live neighbors dies, as if by overcrowding." do
        context '4 live neighbours' do
            let(:start_matrix) do
                [
                    [1, 1, 1],
                    [0, 1, 0],
                    [0, 1, 0]
                ]
            end

            let(:end_matrix) do
                [
                    [1, 1, 1],
                    [0, 0, 0],
                    [0, 0, 0]
                ]
            end

            it { expect(next_generation_matrix).to eq(end_matrix) }
        end
    end
end
