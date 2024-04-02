class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  # anyone can view the list of users
  def index?
    true
  end

  # Users can view anyones profile
  def show?
    true
  end

  # users can create an account for themselves
  def new?
    true
  end

  def create?
    true
  end

  # Users can update their own profile
  def edit?
    update?
  end

  def update?
    user == record
  end

  # Users can delete their own profile
  def destroy?
    user == record
  end

  # Scope class for this policy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
