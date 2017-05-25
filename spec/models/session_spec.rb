require "rails_helper"

RSpec.describe Session do
  describe "::create" do
    subject{Session.create 1}
    it{is_expected.to be_a_kind_of(String)}
  end

  describe "::find_by_token" do
    before{Session.create 1}
    let(:token){Session.find_by_user_id(1)["token"]}
    subject{Session.find_by_token token}
    it{is_expected.to eq "1"}
  end

  describe "::find_by_user_id" do
    before{Session.create 1}
    subject{Session.find_by_user_id 1}
    it{is_expected.to have_key "token"}
    it{expect(subject["token"]).to be_a_kind_of(String)}
  end

  describe "::destroy_by_token" do
    before{Session.create 1}
    let(:token){Session.find_by_user_id(1)["token"]}
    subject{Session.destroy_by_token(token)}
    it{is_expected.to eq 2}
  end
end
