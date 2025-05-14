class TalkPolicy < ApplicationPolicy
  def move?
    create?
  end
end
