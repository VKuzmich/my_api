# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'http://localhost:3000',
          description: 'local server'
        },
        {
          url: 'http://blooming-harbor-05810.herokuapp.com',
          description: 'server on heroku'
          # url: 'http://{defaultHost}',
          # variables: {
          #   defaultHost: {
          #     default: 'www.example.com'
          #   }
          # }
        }
      ]
    }
  }
  config.swagger_format = :yaml
end
