# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    kind { 1 }
    association :account
  end
end
