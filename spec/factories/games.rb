# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    sequence(:name) { |n| "Game ##{n}" }
    kind { :slots }
    credits { 0 }
  end

  trait :frutty_tutty do
    name { "Frutty-Tutty" }
    credits { 10 }
  end
end
