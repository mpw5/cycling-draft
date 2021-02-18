class LeaguePolicy
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
    authorized_to_process?
  end

  def edit?
    update?
  end

  def destroy?
    authorized_to_process?
  end

  def create_team?
    record.pre_draft? && !existing_team?
  end

  private

  def authorized_to_process?
    my_record? && record.pre_draft?
  end

  def my_record?
    record.user_id == user.id
  end

  def existing_team?
    Team.where(user: @user, league: record).present?
  end
end
