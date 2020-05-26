# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransformersController, type: :routing do
  it { expect(get:    "/nickname").to route_to("transformers#show", nickname: "nickname") }
  it { expect(post:   "/transformers").to route_to("transformers#create") }
  it { expect(delete: "/transformers/nickname").to route_to("transformers#destroy", nickname: "nickname") }
end
