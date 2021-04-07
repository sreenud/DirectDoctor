require "rails_helper"

RSpec.describe(Tip, type: :model) do
  describe "associations" do
    it { should have_many(:topic_tips) }
    it { should have_many(:topics).through(:topic_tips) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:summary) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:meta_title) }
    it { should validate_presence_of(:meta_keywords) }
    it { should validate_presence_of(:meta_description) }
    it { should validate_uniqueness_of(:slug) }
  end
end
