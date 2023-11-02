class LabResultsController < ApplicationController
  def new
  end

  def upload
    uploaded_file = params[:lab_file]
    @parsed_results = parse_file(uploaded_file.read)
    @parsed_results = PARSED_RESULTS
    render :show
  end

  private
  def parse_file(file_contents)
    [  # This is just an example of what the parsed results might look like
      { code: 'C100', result: 1.0, format: 'float', comment: ["I'm a comment"] },
      { code: 'C200', result: 2.0, format: 'float', comment: ["I'm a comment too"] }
    ]
  end

end
