class TestsController < Simpler::Controller
  def index; end

  def create; end

  def show
    render plain: "tests id: #{params[:id]}"
  end
end
