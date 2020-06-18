# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'This web-app creates short url.',
        version: '',
        description:
          "Description:

          It works similar to bit.ly.
          This app creates short url for long links.
          When it has been created, you can use in messages where it requires limited numbers of symbols.
          When person use this short url, it will redirect to original link.
          If you do not need this link, you can delete it from database just using short url"
      },
      paths: {},
    }
  }
  config.swagger_format = :yaml
end
