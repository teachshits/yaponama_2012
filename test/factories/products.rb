#encoding: utf-8
#

FactoryGirl.define do

  sequence :catalog_number do |n|
    "Товар #{n}"
  end

  sequence :manufacturer do |n|
    "Производитель #{n}"
  end

  sequence(:random_quantity_ordered) do |n| 
    Random.new.rand(1..5)
  end

  sequence(:random_buy_cost) do |n| 
    Random.new.rand(0.01..5.00)
  end

  sequence(:random_sell_cost) do |n| 
    Random.new.rand(1.10..10.00)
  end

end

FactoryGirl.define do

  factory :product do
    updated_at 0.minutes.ago
    created_at 0.minutes.ago
    catalog_number
    manufacturer
    quantity_ordered { generate(:random_quantity_ordered) }
    buy_cost{ generate(:random_buy_cost) }
    sell_cost{ generate(:random_sell_cost) }

    factory :product_with_user do
      association :user, factory: :minimal_valid_user
    end
  end

end
