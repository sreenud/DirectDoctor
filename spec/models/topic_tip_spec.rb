require 'rails_helper'

RSpec.describe(TopicTip, type: :model) do
  describe 'associations' do
    it { should belong_to(:topic) }
    it { should belong_to(:tip) }
  end
end
