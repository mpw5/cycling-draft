class TeamPolicy
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

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    my_record?
  end

  def edit?
    update?
  end

  def destroy?
    my_record? && record.league.pre_draft?
  end

  private

  def my_record?
    record.user_id == user.id
  end
end
