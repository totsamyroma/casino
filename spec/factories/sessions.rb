FactoryBot.define do
  factory :session do
    game
    player

    score { 1 }

    trait :new

    trait :in_progress do
      state { :in_progress }
    end

    trait :finished do
      state { :finished }
    end

    trait :won do
      state { :won }
    end

    trait :lost do
      state { :lost }
    end
  end
end
