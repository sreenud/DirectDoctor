class Survey < ApplicationRecord
  attr_accessor :question

  validates :email, presence: true

  def self.questions
    [
      "Do you like it when your doctor rushes through your doctor's visit in 10 minutes or less?",
      "Do you like to wait in a never ending line to see your doctor?",
      "Would you like priority access to your doctor (doctor's personal cell number, same day visits etc)?",
      "Do you want to be able to trust your doctor?",
      "Do you like a mediocre quality medical care?",
      "Would you prefer a doctor whose decisions are not influenced by the insurance / corporate companies
        they work for?",
      "Do you like being pushed around to multiple unnecessary specialists & tests for a simple medical problem?",
    ]
  end
end
