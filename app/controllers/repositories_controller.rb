class RepositoriesController < ApplicationController
  def index
    @username = session[:username]

    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers = {
        "Authorization" => "token #{session[:token]}",
        'Accept' => 'application/json'}
    end

    @repos = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers = {
        "Authorization" => "token #{session[:token]}",
        'Accept' => 'application/json'}
      req.body = {name: params[:name]}.to_json
    end
    redirect_to root_path
  end
end
