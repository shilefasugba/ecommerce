module Scopes
  extend ActiveSupport::Concern

  included do
    scope :by_created_at, -> { order('created_at DESC') }
    scope :random, -> { order('RANDOM()') }
  end
end
