//
//  Localizables.swift
//  Localization
//
//  Created by Alfonso Boizas Crespo on 9/11/25.
//

public enum Localizables {

    public enum Common {
        public static let add = "common_add".localized
        public static let edit = "common_edit".localized
        public static let save = "common_save".localized
        public static let gallery = "common_gallery".localized
        public static let maximumHeartRate = "common_maximum_heart_rate".localized
        public static let kilometersUnit = "common_kilometers_unit".localized
        public static let pace = "common_pace".localized
        public static let distance = "common_distance".localized
        public static let time = "common_time".localized
        public static let bpm = "common_bpm".localized
        public static let spm = "common_spm".localized
        public static let years = "common_years".localized
        
        public enum Placeholder {
            public enum Images {
                public static let title = "placeholder_images_title".localized
                public static let subtitle = "placeholder_images_subtitle".localized
            }
            
            public enum Workouts {
                public static let title = "placeholder_workouts_title".localized
                public static let subtitle = "placeholder_workouts_subtitle".localized
            }
        }
    }
    
    public enum Workouts {
        public static let title = "workouts_title".localized
    }
    
    public enum Profile {
        public static let title = "profile_title".localized
        public static let heartRateZonesTitle = "profile_heart_rate_zones_title".localized
        public static let totalKilometers = "profile_total_kilometers".localized
        public static let workoutsRegistered = "profile_workouts_registered".localized
        public static let activityGridFooter = "profile_activity_grid_footer".localized
        
        public enum Months {
            public static let jan = "profile_month_jan".localized
            public static let feb = "profile_month_feb".localized
            public static let mar = "profile_month_mar".localized
            public static let apr = "profile_month_apr".localized
            public static let may = "profile_month_may".localized
            public static let jun = "profile_month_jun".localized
            public static let jul = "profile_month_jul".localized
            public static let aug = "profile_month_aug".localized
            public static let sep = "profile_month_sep".localized
            public static let oct = "profile_month_oct".localized
            public static let nov = "profile_month_nov".localized
            public static let dec = "profile_month_dec".localized
        }
    }
    
    public enum Accessibility {
        public static let loading = "accessibility_loading".localized
        public static let openWorkout = "accessibility_open_workout".localized
        public static let workoutRow = "accessibility_workout_row".localized
        public static let workoutSummary = "accessibility_workout_summary".localized
    }
    
    public enum Search {
        public static let title = "search_title".localized
    }

    public enum WorkoutDetail {
        public static let heartRateTitle = "workout_detail_heart_rate_title".localized
        public static let metricsTitle = "workout_detail_metrics_title".localized

        public enum HeartRateSummary {
            public static let average = "workout_detail_heart_rate_average".localized
            public static let maximum = Localizables.Common.maximumHeartRate
        }

        public enum Metrics {
            public static let cadence = "workout_detail_metrics_cadence".localized
            public static let verticalOscillation = "workout_detail_metrics_vertical_oscillation".localized
            public static let groundContactTime = "workout_detail_metrics_ground_contact_time".localized
        }

        public enum Elevation {
            public static let title = "workout_detail_elevation_title".localized
            public static let maxAltitude = "workout_detail_elevation_max_altitude".localized
            public static let minAltitude = "workout_detail_elevation_min_altitude".localized
        }
    }

    public enum UserConfiguration {
        public static let aboutYou = "user_configuration_about_you".localized
        public static let name = "user_configuration_name".localized
        public static let age = "user_configuration_age".localized
        public static let maximumHeartRate = Localizables.Common.maximumHeartRate
        public static let save = Localizables.Common.save
    }
}
