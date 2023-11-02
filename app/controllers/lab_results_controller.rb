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

    parser = LabFileParser.new(uploaded_file.read)
    @parsed_results = parser.parse_file
    render :show
  end

end
