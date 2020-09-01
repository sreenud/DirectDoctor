FactoryBot.define do
  factory :tip do
    name { "MyString" }
    slug { "MyString" }
    summary { "MyText" }
    content { "MyText" }
    authour_id { 1 }
    meta_title { "MyString" }
    meta_keywords { "" }
    meta_description { "MyText" }
    h1_tag { "MyString" }
  end
end
