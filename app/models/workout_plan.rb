class WorkoutPlan < ActiveRecord::Base
  belongs_to :user
  has_many :exercises
  has_many :workouts, through: :exercises

  def all_muscle_groups
    self.exercises.collect{ |exercise| exercise.muscle_group.name.downcase }.uniq
  end

  NAMES = {
    1 => "Chest",
    "Chest" => 2
  }

  def exercises_by_group(name)
    exercises.where(muscle_group_id: NAMES[name])
  end

  def created_date
    created_at.strftime("%A, %b %d")
  end

  def chest_exercises
    exercises.where(muscle_group_id: 1)
  end

  def back_exercises
    exercises.where(muscle_group_id: 2)
  end

  def legs_exercises
    exercises.where(muscle_group_id: 3)
  end

  def shoulders_exercises
    exercises.where(muscle_group_id: 4)
  end

  def bis_exercises
    exercises.where(muscle_group_id: 5)
  end

  def tris_exercises
    exercises.where(muscle_group_id: 6)
  end

  def abs_exercises
    exercises.where(muscle_group_id: 7)
  end
end
