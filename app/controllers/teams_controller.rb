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

  private

  def team_params
    params.require(:team).permit(:name)
  end

  def league
    @league ||= League.find(params[:league_id])
  end

  def team
    @team ||= Team.find(params[:id])
  end
end
