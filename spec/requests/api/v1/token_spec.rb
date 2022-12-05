require 'swagger_helper'

RSpec.describe 'Api::V1::Token', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:token) { { api_key: user.api_key } }

  path '/api/v1/token' do
    post('authenticate user') do
      tags 'Token'
      description 'Authenticate user'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :token, in: :body, schema: {
        type: :object,
        properties: {
          api_key: {
            type: :string
          }
        }
      }

      response(200, 'successful') do
        schema type: :object,
          properties: {
            token: {
              type: :string
            }
          },
          required: [:token]

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
