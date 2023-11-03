class LabFileParser
  attr_reader :file, :results

  def initialize(file)
    @file = file
    @results = []
  end

  def parse_file
    lines = @file.split("\n")
    current_obx = nil

    lines.each do |line|
      parts = line.split('|')


      if parts[0] != 'OBX' && parts[0] != 'NTE'
        raise StandardError, 'Invalid file format'
      end

      # Parse OBX lines
      if parts[0] == 'OBX'
        current_obx = {
          code: parts[2],
          result: transform_result(parts[2], parts[3]),
          format: get_format(parts[2]),
          comment: []
        }
        @results << current_obx
      end

      # Parse NTE lines
      if parts[0] == 'NTE' && current_obx
        current_obx[:comment] << parts[2]
      end
    end

    @results
  end

  def transform_result(code, value)
    case get_format(code)
    when 'float'
      value.to_f
    when 'boolean'
      value == 'NEGATIVE' ? -1.0 : -2.0
    when 'nil_3plus'
      { 'NIL' => -1.0, '+' => -2.0, '++' => -2.0, '+++' => -3.0 }[value]
    else
      value
    end
  end

  def get_format(code)
    {
      'C100' => 'float',
      'C200' => 'float',
      'A250' => 'boolean',
      'B250' => 'nil_3plus'
    }[code]
  end
end
