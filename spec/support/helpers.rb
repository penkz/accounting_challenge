# frozen_string_literal: true

module Helpers
  def json_response
    JSON.parse(response.body)
  end
end
