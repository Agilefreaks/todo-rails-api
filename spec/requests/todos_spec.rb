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
end
