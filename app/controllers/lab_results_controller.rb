class LabResultsController < ApplicationController

  def new
  end

  def upload
    uploaded_file = params[:lab_file]
    # make sure a file is uploaded
    unless uploaded_file
      return render json: { error: 'No file provided' }, status: :unprocessable_entity
    end

    # ensure it is s text file
    unless ['text/plain'].include?(uploaded_file.content_type)
      return render json: { error: 'Unsupported file type' }, status: :unprocessable_entity
    end

    @parsed_results = parse_file(uploaded_file.read)
    render :show
  end

  private

  def parse_file(file_content)
    lines = file_content.split("\n")
    results = []
    current_obx = nil

    lines.each do |line|
      parts = line.split('|')

      # Parse OBX lines
      if parts[0] == 'OBX'
        current_obx = {
          code: parts[2],
          result: transform_result(parts[2], parts[3]),
          format: get_format(parts[2]),
          comment: []
        }
        results << current_obx
      end

      # Parse NTE lines
      if parts[0] == 'NTE' && current_obx
        current_obx[:comment] << parts[2]
      end
    end

    results
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
