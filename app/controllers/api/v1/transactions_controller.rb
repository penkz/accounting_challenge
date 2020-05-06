# frozen_string_literal: true

module Api
  module V1
    class TransactionsController < ApplicationController
      def create
        outcome = Transactions::Create.run(
          source_account_id: transaction_params[:source_account_id],
          destination_account_id: transaction_params[:destination_account_id],
          amount: transaction_params[:amount]
        )

        if outcome.success?
          render :create, status: :created
        else
          render json: { errors: outcome.errors.message }, status: :unprocessable_entity
        end
      end

      def transaction_params
        params[:transaction]
      end
    end
  end
end
