# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'associations' do
    it { should belong_to :account }
  end

  describe 'enums' do
    it 'has kind enum' do
      expect(described_class.new).to define_enum_for(:kind).with_values(withdraw: 0, deposit: 1)
    end
  end
end
