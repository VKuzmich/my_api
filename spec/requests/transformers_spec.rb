# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'transformers', type: :request do
  path '/transformers' do
    post 'Creates ' do
      tags 'create nickname'
      consumes 'application/json'
      parameter name: :transformer, in: :body, schema: {
        type: :object,
        properties: {
          user_url: { type: :string }
        },
        required: %w[user_url]
      }

      response '200', 'transformer created' do
        let(:transformer) { { user_url: 'google.com' } }
        run_test!
      end

      response '302', 'invalid url' do
        let(:invalid_url) { { user_url: 'goo' } }
        let(:transformer) { { user_url: :invalid_url } }
        run_test!
      end
    end
  end

  path '/{nickname}' do
    get 'gets ' do
      tags 'show link'
      consumes 'application/json'
      parameter name: :nickname, in: :path, type: :string

      response '200', 'transformer gets' do
        let(:nickname) { Transformer.create(user_url: 'google.com').nickname }
        run_test!
      end
      response '404', 'invalid request' do
        let(:nickname) { 'nickname' }
        run_test!
      end
    end
  end

  path '/transformers/{nickname}' do
    delete 'destroy nickname' do
      tags 'destroy link and nickname'
      consumes 'application/json'
      parameter name: :nickname, in: :path, type: :string

      response '200', 'No content' do
        let(:nickname) { Transformer.create(user_url: 'google.com').nickname }
        let(:message) { 'removed' }
        run_test!
      end

      response '404', :not_found do
        let(:nickname) { 'invalid' }
        run_test!
      end
    end
  end
end
