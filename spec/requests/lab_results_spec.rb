require 'rails_helper'

RSpec.describe "LabResults", type: :request do
  describe "POST /upload" do
    let(:file) { fixture_file_upload('sample_lab_file.txt', 'text/plain') }

    it "parses the uploaded lab results file and renders the results" do
      post upload_lab_results_path, params: { lab_file: file }
      expect(response).to have_http_status(:success)

      expect(response.body).to include("C100")
      expect(response.body).to include("20")
      expect(response.body).to include("Comment for C100 result")
    end

    it "returns an error when no file is uploaded" do
      post upload_lab_results_path

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("No file provided")
    end

    it "returns an error for an unsupported file type" do
      file = fixture_file_upload('some_image.jpg', 'image/jpeg')
      post upload_lab_results_path, params: { lab_file: file }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("Unsupported file type")
    end
  end
end
