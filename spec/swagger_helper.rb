# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'This web creates short url. It looks like a clone of bit.ly',
        version: '',
        description:
              'Create short url, Get original link, Destroy url from database '

      },
      paths: {},
      #
      # servers: [
      #   {
      #     url: '/'
      #   }
      # ]
    }
  }
  config.swagger_format = :yaml
end
