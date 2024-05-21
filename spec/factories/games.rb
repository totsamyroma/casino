FactoryBot.define do
  factory :game do
    name { "MyString" }
    kind { :slots }
    credits { 0 }
  end

  trait :frutty_tutty do
    name { "Frutty-Tutty" }
    credits { 10 }
  end
end
