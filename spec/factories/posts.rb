FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }

    factory :published_post do
      published_at { Faker::Date.backward(100) }
    end


  end
end
