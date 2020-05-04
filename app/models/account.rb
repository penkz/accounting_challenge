# frozen_string_literal: true

class Account < ApplicationRecord
  validates :name, presence: true
  validates :id, uniqueness: true

  has_many :transactions
end
