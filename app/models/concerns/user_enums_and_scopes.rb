module UserEnumsAndScopes
  extend ActiveSupport::Concern

  included do
    enum user_gym: {

           east_bank_club: "east_bank_club",
           esporta_Fitness: "esporta_fitness",
           equinox: "equinox",
           la_fitness: "la_fitness",
           planet_fitness: "planet_fitness",
           fitness_formula_club: "fitness_formula_club",
           midtown_athletic_club: "midtown_athletic_club",
           orange_theory_fitness: "orange_theory_fitness",
         }

    enum gender: { male: "male", female: "female", nonbinary: "nonbinary" }
    enum gym_frequency_category: {
      daily: "daily",
      twice_a_week: "twice_a_week",
      multiple_times_a_week: "multiple_times_a_week",
      weekly: "weekly",
      every_two_weeks: "every_two_weeks",
      occasionally: "occasionally",
      rarely: "rarely",
    }
    enum skill_level: { beginner: "beginner", intermediate: "intermediate", advanced: "advanced" }
    enum time_of_day: { mornings: "mornings", afternoons: "afternoons", evenings: "evenings" }
    enum type_of_workouts: {
      cardio: "cardio",
      strength_training: "strength_training",
      hiit: "hiit",
      crossfit: "crossfit",
      yoga: "yoga",
      pilates: "pilates",
      dance: "dance",
      martial_arts: "martial_arts",
      spinning: "spinning",
      bodybuilding: "bodybuilding",
      mixed_modal: "mixed_modal",
    }

    scope :all_except, ->(user) { where.not(id: user) }
  end
end
