class ApisController < ApplicationController
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  before_filter :allow_cors

  def fetch_records
    respond_to do |format|
      user = User.find_by_uuid(params[:uuid])
      if user
        data = user.games.as_json(:include => :attempts)
        format.json { render :json => { :data => data } }
      else
        format.json { render :json => { :data => {} } }
      end
    end
  end

  def create_record
    respond_to do |format|
      user = User.find_by_uuid(params[:user_params][:uuid])
      unless user
        user = User.create(user_params)
      end
      game = Game.create(game_params)
      game.update_attributes(:user_id => user.id)

      attempts = params[:attempts]

      attempts.keys.each do |key|
        Attempt.create(
          :guess => attempts[key]["guess"],
          :result => attempts[key]["result"],
          :game_id => game.id
        )
      end
      format.json { render :json => { :status => "Great success!" } }
    end
  end

  def get_username
    respond_to do |format|
      user = User.find_by_uuid(params[:uuid])
      if user
        format.json { render :json => { :username => user.username } }
      else
        format.json { render :json => { :username => "" } }
      end
    end
  end

  def get_score
    respond_to do |format|
      user = User.find_by_uuid(params[:uuid])
      if user
        data = {
          :score => user.score,
          :high_scores => User.high_scores(3),
          :fastest_by_digit => Game.fastest_by_digit(3)
        }
        format.json { render :json => data }
      else
        format.json { render :json => {} }
      end
    end
  end

  def update_username
    respond_to do |format|
      user = User.find_by_uuid(params[:user_params][:uuid])
      if user
        user.update_attributes(:username => params[:user_params][:username])
      else
        User.create(user_params)
      end
      format.json { render :json => { :status => "Great success!" } }
    end
  end

  private

  def allow_cors
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Methods"] = %w{GET POST PUT DELETE}.join(",")
    headers["Access-Control-Allow-Headers"] =
      %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(",")

    head(:ok) if request.request_method == "OPTIONS"
  end

  def user_params
    params.require(:user_params).permit(
      :uuid,
      :username,
      :platform,
      :model,
      :created_at,
      :updated_at,
      :_destroy
    )
  end

  def game_params
    params.require(:game_params).permit(
      :answer,
      :result,
      :time,
      :digits,
      :repeat,
      :created_at,
      :updated_at,
      :_destroy
    )
  end
end