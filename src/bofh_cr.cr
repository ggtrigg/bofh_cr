# TODO: Write documentation for `BofhCr`
require "kemal"

module BofhCr
  VERSION = "0.1.0"
  
  all_excuses = File.read("bofh_excuses.txt").split "\n"

  get "/" do |env|
    count = env.params.query["count"]? || "1"
    begin
      excuses = all_excuses.sample count.to_i
    rescue
      excuses = all_excuses.sample 1
    end
    render "views/excuse.ecr"
  end
  
  error 404 do
    render "views/p404.ecr"
  end

  begin
    Kemal.run
  rescue exception
    puts exception.message
  end

end
