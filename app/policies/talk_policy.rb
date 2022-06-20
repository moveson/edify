# frozen_string_literal: true

class TalkPolicy < ApplicationPolicy
  def move?
    create?
  end
end
