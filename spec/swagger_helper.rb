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
          This app creates short url for long links. You can find it after: 'redirect_url:'
          When it has been created, you can use it in messages where it requires limited numbers of symbols.
          In order to get original link, just paste short url to browser's address bar and press 'Enter'.
          If you do not need this link, you can delete it from database just using symbols after '/' in your short url."
      },
      paths: {},
    }
  }
  config.swagger_format = :yaml
end
