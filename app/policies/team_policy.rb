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
    my_record? && record.league.aasm_state == 'pre_draft'
  end

  def new?
    create?
  end

  def update?
    my_record? && my_turn_to_draft? && record.league.aasm_state == 'drafting'
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

  def my_turn_to_draft?
    record.draft_position == record.league.current_draft_position
  end
end
