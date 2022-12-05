require 'swagger_helper'

RSpec.describe 'Api::V1::Voyages', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:token) { TokenService.encode(user_id: user.id) }
  let(:vessel) { FactoryBot.create(:vessel, user: user) }

  path '/api/v1/vessels/{vessel_id}/voyages' do
    get('list voyages') do
      tags 'Voyages'
      description 'Get list of voyages'
      security [jwt_token: []]
      consumes 'application/json'
      produces 'application/json'
      parameter name: 'vessel_id', in: :path, type: :string, description: 'vessel id'
      parameter name: :page, in: :query, type: :integer, required: false
      parameter name: :size, in: :query, type: :integer, required: false

      response(200, 'successful') do
        let(:Authorization) { "Bearer #{token}" }
        let(:vessel_id) { vessel.id }

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

    post('create voyage') do
      tags 'Voyages'
      description 'Create a voyage'
      security [jwt_token: []]
      consumes 'application/json'
      produces 'application/json'
      parameter name: 'vessel_id', in: :path, type: :string, description: 'vessel id'
      parameter name: :voyage, in: :body, schema: {
        type: :object,
        properties: {
          from_loc: {
            type: :string
          },
          to_loc: {
            type: :string
          },
          departured_at: {
            type: :string
          },
          arrived_at: {
            type: :string
          }
        },
        required: %i[
          from_loc
          to_loc
          departured_at
          arrived_at
        ]
      }

      response(201, 'successful') do
        let(:Authorization) { "Bearer #{token}" }
        let(:vessel_id) { vessel.id }
        let(:voyage) { FactoryBot.attributes_for(:voyage, vessel: vessel) }

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

  path '/api/v1/vessels/{vessel_id}/voyages/{id}' do
    let!(:voyage_1) { FactoryBot.create(:voyage, vessel: vessel) }

    patch('update voyage') do
      tags 'Voyages'
      description 'Update a voyage'
      security [jwt_token: []]
      consumes 'application/json'
      produces 'application/json'
      parameter name: 'vessel_id', in: :path, type: :string, description: 'vessel id'
      parameter name: 'id', in: :path, type: :string, description: 'id'
      parameter name: :voyage, in: :body, schema: {
        type: :object,
        properties: {
          from_loc: {
            type: :string
          },
          to_loc: {
            type: :string
          },
          departured_at: {
            type: :string
          },
          arrived_at: {
            type: :string
          }
        },
        required: %i[
          from_loc
          to_loc
          departured_at
          arrived_at
        ]
      }

      response(200, 'successful') do
        let(:Authorization) { "Bearer #{token}" }
        let(:id) { voyage_1.id }
        let(:vessel_id) { vessel.id }
        let(:voyage) { FactoryBot.attributes_for(:voyage, vessel: vessel) }

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

    put('update voyage') do
      tags 'Voyages'
      description 'Update a voyage'
      security [jwt_token: []]
      consumes 'application/json'
      produces 'application/json'
      parameter name: 'vessel_id', in: :path, type: :string, description: 'vessel id'
      parameter name: 'id', in: :path, type: :string, description: 'id'
      parameter name: :voyage, in: :body, schema: {
        type: :object,
        properties: {
          from_loc: {
            type: :string
          },
          to_loc: {
            type: :string
          },
          departured_at: {
            type: :string
          },
          arrived_at: {
            type: :string
          }
        },
        required: %i[
          from_loc
          to_loc
          departured_at
          arrived_at
        ]
      }

      response(200, 'successful') do
        let(:Authorization) { "Bearer #{token}" }
        let(:id) { voyage_1.id }
        let(:vessel_id) { vessel.id }
        let(:voyage) { FactoryBot.attributes_for(:voyage, vessel: vessel) }

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
