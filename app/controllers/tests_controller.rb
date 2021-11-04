class TestsController < Simpler::Controller

  def show
    set_header('Content-Language', 'en')
    # render plain: "Show time! params ARE: #{params}", status: 201
  end

  def index
    @time = Time.now
    render plain: "Index here! params ARE: #{params}"
  end

  def create

  end

end
