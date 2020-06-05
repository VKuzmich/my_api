# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransformersController, type: :routing do
  it do
    expect(get: '/nickname')
      .to route_to('transformers#show', nickname: 'nickname')
  end
  it do
    expect(post: '/transformers')
      .to route_to('transformers#create')
  end
  it do
    expect(delete: '/transformers/nickname')
      .to route_to('transformers#destroy', nickname: 'nickname')
  end
end
