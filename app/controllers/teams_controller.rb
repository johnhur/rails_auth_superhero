class TeamsController < SessionsController
  # def index
  # end
  before_action :find_user, only: [:index, :new, :create]
  before_action :find_team, only: [:show, :edit, :update, :destroy]



  def index
    @teams = Team.all
  end

  def new
    #@superheroes = Superheroes.all
  	@team = Team.new
  end

  def create
  	@team = @user.teams.create(team_params)
  		if @team.save
  			flash[:success] = "Team Created"
  			redirect_to user_teams_path(@team)
  		else
  			@errors = @team.errors.full_messages
  			render :new
  		end

  end


  def show

  end


  def edit
  end

  def update
  	@team.update(team_params)
  	if @team.save
		redirect_to team_path(@team), notice: "Team has been edited!"
		else
			render :edit
		end
  end


  private

  def find_user
    @user = User.find_by_id params[:user_id]
  end

  def find_team
    @team = Team.find params[:id]
  end

  def team_params
  	params.require(:team).permit(:name, :description, :id, :user_id)
  end

end
