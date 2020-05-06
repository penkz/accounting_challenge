# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :account

  enum kind: %i[withdraw deposit]
end
