class ExercisesController < ApplicationController
  def new
    @exercise = Exercise.new
  end

  def create
    current_user.current_plan.exercises.create(exercise_params)
    redirect_to workout_plan_path(current_user.current_plan)
  end

  private

  def exercise_params
    params.require(:exercise).permit(:muscle_group_id, :workouts_attributes => [:name, :sets, :reps])
  end
end
