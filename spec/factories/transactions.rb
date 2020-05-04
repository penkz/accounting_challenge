# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    type { 1 }
    association :account
  end
end
