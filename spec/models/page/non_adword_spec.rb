require "rails_helper"

RSpec.describe Page::NonAdword, type: :model do
  let!(:page_content){Nokogiri::HTML File.read([Rails.root, "/spec/fixtures/content.txt"].join).gsub("\\", "")}
  
  describe "#total" do
    subject{Page::NonAdword.new(page_content).total}
    it{is_expected.to eq 10}
  end

  describe "#urls" do
    subject{Page::NonAdword.new(page_content).urls}
    it{is_expected.to eq ["https://www.lynda.com/Google-AdWords-training-tutorials/488-0.html",
      "https://www.jellyfish.co.uk/training/online-courses/google-adwords",
      "https://www.webcredible.com/training/google-adwords-ppc-training/",
      "https://generalassemb.ly/education/crash-course-in-google-adwords/melbourne",
      "http://www.bolc.co.uk/adwords-online-course.html",
      "http://www.oxfordcollegeofmarketing.com/short-courses/seo-ppc/",
      "http://www.fitzwilliaminstitute.ie/online-postgraduate-courses/digital-marketing-courses",
      "http://www.scs.cuhk.edu.hk/en/part-time/marketing-public-relations-and-business-communication/internet-marketing-and-e-business/digital-marketing-strategies-using-google-adwords",
      "https://www.auckland.ac.nz/en/for/current-students/career-development-and-employability-services/events/2015/06/Digital-Media-and-AdWords-Programme.html",
      "http://seoforbeginners.com/seo-certifications-courses/"]}
  end
end


