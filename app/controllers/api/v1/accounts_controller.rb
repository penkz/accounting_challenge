# frozen_string_literal: true

module Api
  module V1
    class AccountsController < ApplicationController
      before_action :create_account, only: [:create]
      before_action :authenticate, except: %i[create show]

      def create
        if @outcome.success?
          @resource = @outcome.result
          @jwt = JsonWebToken.encode({ id: @resource.to_param, name: @resource.name })
          render :create, status: :created
        else
          render json: { errors: @outcome.errors.message }, status: :unprocessable_entity
        end
      end

      def show
        @resource = Accounts::Show.run!(id: params[:id])
      end

      private

      def create_account
        @outcome = Accounts::Create.run(
          id: account_params[:id],
          name: account_params[:name],
          balance: account_params[:balance]
        )
      end

      def account_params
        params[:account]
      end
    end
  end
end
