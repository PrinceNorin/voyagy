require 'swagger_helper'

RSpec.describe 'Api::V1::Vessels', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:token) { TokenService.encode(user_id: user.id) }

  path '/api/v1/vessels' do
    get('list vessels') do
      tags 'Vessels'
      description 'Get list of vessels'
      security [jwt_token: []]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :page, in: :query, type: :integer, required: false
      parameter name: :size, in: :query, type: :integer, required: false

      response(200, 'successful') do
        let(:Authorization) { "Bearer #{token}" }

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

    post('create vessel') do
      tags 'Vessels'
      description 'Create a vessel'
      security [jwt_token: []]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :vessel, in: :body, schema: {
        type: :object,
        properties: {
          name: {
            type: :string
          },
          owner_id: {
            type: :string
          },
          naccs: {
            type: :string
          }
        },
        required: %i[name owner_id naccs]
      }

      response(201, 'successful') do
        let(:Authorization) { "Bearer #{token}" }
        let(:vessel) { FactoryBot.attributes_for(:vessel) }

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

  path '/api/v1/vessels/{id}' do
    let!(:vessel_1) { FactoryBot.create(:vessel, user: user) }

    patch('update vessel') do
      tags 'Vessels'
      description 'Update a vessel'
      security [jwt_token: []]
      consumes 'application/json'
      produces 'application/json'
      parameter name: 'id', in: :path, type: :string, description: 'id'
      parameter name: :vessel, in: :body, schema: {
        type: :object,
        properties: {
          name: {
            type: :string
          },
          owner_id: {
            type: :string
          },
          naccs: {
            type: :string
          }
        },
        required: %i[name owner_id naccs]
      }

      response(200, 'successful') do
        let(:Authorization) { "Bearer #{token}" }
        let(:id) { vessel_1.id }
        let(:vessel) { FactoryBot.attributes_for(:vessel) }

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

    put('update vessel') do
      tags 'Vessels'
      description 'Update a vessel'
      security [jwt_token: []]
      consumes 'application/json'
      produces 'application/json'
      parameter name: 'id', in: :path, type: :string, description: 'id'
      parameter name: :vessel, in: :body, schema: {
        type: :object,
        properties: {
          name: {
            type: :string
          },
          owner_id: {
            type: :string
          },
          naccs: {
            type: :string
          }
        },
        required: %i[name owner_id naccs]
      }

      response(200, 'successful') do
        let(:Authorization) { "Bearer #{token}" }
        let(:id) { vessel_1.id }
        let(:vessel) { FactoryBot.attributes_for(:vessel) }

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
