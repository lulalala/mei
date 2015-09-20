FactoryGirl.define do
  factory :board do
    sequence(:name){|n| "Board #{n}" }
    sequence(:seo_name){|n| "board#{n}" }
  end
end
