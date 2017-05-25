require "spec_helper"

describe "Login API" do
  shared_examples_for "request to be succeed" do
    describe "succeed" do
      subject{response}
      it{should be_success}
    end
    describe "returns access_token" do
      subject{json["access_token"]}
      it{should be_a String}
    end
  end
  shared_examples_for "request to be internal server error" do
    describe "response json" do
      subject {json}
      it {is_expected.to include("message" => "Invalid Params", "status" => 12)}

      describe "has 2 fields" do
        subject {json.count == 2}
        it {is_expected.to be true}
      end
    end
  end

  shared_examples_for "request to be not_found" do
    describe "response json" do
      subject {json}
      it {is_expected.to include("message" => "Invalid Email or Password", "status" => 11)}

      describe "has 3 fields" do
        subject {json.count == 2}
        it {is_expected.to be true}
      end
    end
  end

  let(:user){FactoryGirl.create :user}

  let(:endpoint){"/api/login"}
  let :user_json do
    <<-EOJ
    {
      "user":{
        "email":"#{user.email}",
        "password":"test12345"
      }
    }
    EOJ
  end

  let :empty_json do
    <<-EOJ
    {}
    EOJ
  end

  let :wrong_password_json do
    <<-EOJ
    {
      "user":{
        "email":"#{user.email}",
        "password":"test123456"
      }
    }
    EOJ
  end

  context "with valid email and password" do
    before{post endpoint, user_json, Consts::HEADER}
    it_behaves_like "request to be succeed"
  end

  context "wrong empty json" do
    before{post endpoint, empty_json, Consts::HEADER}
    it_behaves_like "request to be internal server error"
  end

  context "wrong password json" do
    before{post endpoint, wrong_password_json, Consts::HEADER}
    it_behaves_like "request to be not_found"
  end
end
