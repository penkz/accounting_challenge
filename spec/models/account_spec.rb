# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :id }
  end

  describe 'associations' do
    it { should have_many :transactions }
  end
end
