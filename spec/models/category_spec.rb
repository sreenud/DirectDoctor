require "rails_helper"

RSpec.describe(Category, type: :model) do
  describe "associations" do
    it { should have_many(:topics) }
  end
end
