class TeamsController < ApplicationController
  before_action :authenticate_user!

  def new
    @team = league.teams.build
  end

  def create
    @team = league.teams.build(team_params)
    if @team.save
      redirect_to league_path(league)
    else
      render :new
    end
  end

  def show
    team
  end

  def destroy
    team.destroy
    redirect_to league_path(league)
  end

  def update
    RiderTeamLeague.new(rider_id: params[:rider_id], team_id: team.id, league_id: league.id).save!
    team
    render :show
  end

  private

  def team_params
    params.require(:team).permit(:name, :rider_id).merge(user_id: current_user.id)
  end

  def league
    @league ||= League.find(params[:league_id])
  end

  def team
    @team ||= Team.find(params[:id])
  end
end
