require 'spec_helper'
load 'lib/alive_cells.rb'

describe NextGeneration do
    context 'any live cell with less then 2 neighbours should be dead' do
        let(:generator) { NextGeneration.new(start_matrix) }

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

            it { expect(generator.next.matrix).to eq(end_matrix) }
        end
    end
end
