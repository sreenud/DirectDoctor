FactoryBot.define do
  factory :topic do
    name { "MyString" }
    slug { "MyString" }
    summary { "MyText" }
    content { "MyText" }
    is_popular { false }
    author_id { 1 }
    meta_title { "MyString" }
    meta_keywords { "" }
    meta_description { "MyText" }
    h1_tag { "MyString" }
  end
end
