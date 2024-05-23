# frozen_string_literal: true

FactoryBot.define do
  factory :player do
    sequence(:nick) { |n| "Player ##{n}" }
    credits { 0 }
  end
end
