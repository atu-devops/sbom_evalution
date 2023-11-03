require 'rails_helper'

RSpec.describe LabFileParser do
  let(:file_path) { Rails.root.join('spec', 'fixtures', 'files', 'sample_lab_file.txt') }
  let(:file) { File.open(file_path).read }
  let(:parser) { LabFileParser.new(file) }

  describe '#initialize' do
    it 'initializes with a file' do
      expect(parser.file).to eq(file)
    end
  end

  describe '#parse' do
    context 'with a valid file' do
      it 'parses the lab results correctly' do
        results = parser.parse_file
        expect(results.size).to eq(4) # Assuming the sample file has 2 results

        first_result = results.first
        expect(first_result[:code]).to eq('C100')
        expect(first_result[:result]).to eq(20.0)
        expect(first_result[:format]).to eq('float')
        expect(first_result[:comment]).to include('Comment for C100 result')
      end
    end

    context 'with an invalid file' do
      let(:file_path) { Rails.root.join('spec', 'fixtures', 'files','invalid_lab_file.txt') }
      let(:file) { File.open(file_path).read }
      let(:parser) { LabFileParser.new(file) }

      it 'raises an appropriate error' do
        expect { parser.parse_file }.to raise_error(StandardError, 'Invalid file format')
      end
    end
  end
end
