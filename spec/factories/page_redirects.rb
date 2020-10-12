FactoryBot.define do
  factory :page_redirect do
    old { "MyString" }
    new { "" }
    redirect_code { 1 }
  end
end
