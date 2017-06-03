require "rails_helper"

RSpec.describe ImportKeyword, type: :model do
  describe "validations presence" do
    it{should validate_presence_of(:user_id)}
    it{should validate_presence_of(:file)}
  end

  describe "#save" do
    let(:user){FactoryGirl.create :user}
    let(:empty_file) do
      ActionDispatch::Http::UploadedFile.new type: "text/csv",
        tempfile: [Rails.root, "/spec/fixtures/empty_file.csv"].join
    end
    let(:invalid_keywords_file) do
      ActionDispatch::Http::UploadedFile.new type: "text/csv",
        tempfile: [Rails.root, "/spec/fixtures/invalid_keywords_file.csv"].join
    end
    let(:valid_keywords_file) do
      ActionDispatch::Http::UploadedFile.new type: "text/csv",
        tempfile: [Rails.root, "/spec/fixtures/valid_keywords_file.csv"].join
    end

    context "when user_id nil" do
      let(:import_keyword){ImportKeyword.new file: valid_keywords_file}
      subject{import_keyword.save}
      it{is_expected.to eq false}
    end

    context "when empty file" do
      let(:import_keyword) do
        ImportKeyword.new user_id: user.id, file: empty_file
      end
      subject{import_keyword.save}
      it{is_expected.to eq false}
    end

    context "when invalid keywords file" do
      let(:import_keyword) do
        ImportKeyword.new user_id: user.id, file: invalid_keywords_file
      end
      subject{import_keyword.save}
      it{is_expected.to eq false}
    end

    context "when valid keywords file" do
      let(:import_keyword) do
        ImportKeyword.new user_id: user.id, file: valid_keywords_file
      end
      subject{import_keyword.save}
      it{is_expected.to eq true}
    end
  end
end
