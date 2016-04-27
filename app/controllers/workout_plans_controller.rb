class WorkoutPlansController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :destroy]
  before_action :set_workout_plan, only: [:show, :edit, :update, :destroy]

  def index
    @all_workout_plans = WorkoutPlan.all.select{ |workout_plan| workout_plan.user_id != current_user.id }
    @workout_plans = current_user.workout_plans
    respond_to do |format|
      format.html {render :index}
      format.json {
        render json: {
          workouts: @workout_plans,
          all_workouts: @all_workout_plans
        }
      }
    end
  end

  def show
    @exercises = @workout_plan.exercises
    respond_to do |format|
      format.html {render :index}
      format.json {render json: @exercises}
    end
  end

  def new
    current_user.new_plan
    redirect_to new_workout_plan_exercise_path(current_user.current_plan)
  end

  def destroy
    if @workout_plan.user == current_user
      @workout_plan.destroy
      redirect_to workout_plans_path(current_user), notice: 'Successfully deleted your workout plan.'
    else
      redirect_to root_path, alert: 'Access Denied'
    end
  end

  private

  def set_workout_plan
    @workout_plan = WorkoutPlan.find(params[:id])
  end
end
