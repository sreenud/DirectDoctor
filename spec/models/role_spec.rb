require "rails_helper"

RSpec.describe(Role, type: :model) do
  describe "associations" do
    it { should have_and_belong_to_many(:users) }
  end
end
