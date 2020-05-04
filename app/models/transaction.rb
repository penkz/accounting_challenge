# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :account

  enum type: %i[withdraw deposit]
end
