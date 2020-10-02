require 'rails_helper'

RSpec.describe(Topic, type: :model) do
  describe "associations" do
    it { should have_many(:topic_tips) }
    it { should have_many(:tips).through(:topic_tips) }
    it { should belong_to(:category).optional }
    it { should belong_to(:author).class_name('User').with_foreign_key('author_id').optional }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:summary) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:meta_title) }
    it { should validate_presence_of(:read_time) }
    it { should validate_presence_of(:meta_description) }
    it { should validate_presence_of(:author_id) }
    it { should validate_uniqueness_of(:slug) }
  end
end
