class TestsController < Simpler::Controller

  def show
    set_header('Content-Language', 'en')
    render inline: "<h1>Show time!</h1> <p>params ARE: #{params}</p>", status: 201
  end

  def index
    @time = Time.now
    # render plain: "<h1>Index here! params ARE: #{params}</h1>"
    # render template: "tests/list"
  end

  def create

  end

end
