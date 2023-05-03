# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    id { SecureRandom.uuid }
    title { FFaker::Company.name }
    description { FFaker::Company.name }
  end
end

  