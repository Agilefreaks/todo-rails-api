require 'swagger_helper'

RSpec.describe 'todos', type: :request do
  path '/' do
    get('list todos') do
      tags 'Todos'
      response(200, 'Test successful') do
        let(:todos) { { message: 'Test successful' } }
        run_test!
      end
    end
  end

  path '/todos' do
    post 'Create a todo' do
      tags 'Todos'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :todo, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          due_date: { type: :string, format: :date }
        },
        required: %w[title description]
      }

      request_body_example value: {
        title: 'Write doc first api',
        description: 'Write an example to prove that doc first apis are possible',
        due_date: '2023-10-22'
      }

      response '201', 'todo created' do
        schema type: :object, properties: {
          id: { type: :string, format: :guid },
          title: { type: :string },
          description: { type: :string },
          due_date: { type: :string, format: :date }
        }

        example 'application/json', :created_response, {
          id: "1fe83061-ec9e-464f-8043-3d549df254f2",
          title: 'Write doc first api',
          description: 'Write an example to prove that doc first apis are possible',
          due_date: '2023-10-22'
        }

        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end
end
