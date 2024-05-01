class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    update?
  end

  def update?
    user == record
  end

  def destroy?
    user == record
  end


  def messages?
    user == record
  end
  

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
