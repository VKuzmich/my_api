# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'transformers', type: :request do
  path '/transformers' do
    post '' do
      tags 'Create short link'
      consumes 'application/json'
      parameter name: :transformer, in: :body, schema: {
        type: :object,
        properties: {
          user_url: { type: :string }
        },
        required: %w[user_url]
      }

      response '200', 'short url created' do
        let(:transformer) { { user_url: 'google.com' } }
        run_test!
      end

      response '422', 'invalid url' do
        let(:invalid_url) { { user_url: 'goo' } }
        let(:transformer) { { user_url: :invalid_url } }
        run_test!
      end
    end
  end

  path '/{nickname}' do
    get '' do
      tags 'Show link'
      consumes 'application/json'
      parameter name: :nickname, in: :path, type: :string

      response '200', 'get url' do
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
    delete '' do
      tags 'Destroy saved link and short url'
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
