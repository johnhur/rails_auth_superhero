class TeamsController < SessionsController
  # def index
  # end
  before_action :find_team, only: [:show, :edit, :update, :destroy]

  def new
  	@team = Team.new
  end

  def create
  	@team = Team.create(team_params)
  		if @team.save
  			flash[:success] = "Team Created"
  			redirect_to home_path
  		else
  			@errors = @team.errors.full_messages
  			render :new
  		end

  end

  def edit
  end

  def update
  	@team.update(team_params)
  	if @team.save
		redirect_to teams_path(@team), notice: "Team has been edited!"
		else
			render :edit
		end
  end

  def show
  end


  private

  def find_team
  	@team = Team.find params[:id]
  end

  def find_user
  	@user = User.find params[:id]
  end

  def team_params
  	params.require(:team).permit(:name, :description)
  end

end
