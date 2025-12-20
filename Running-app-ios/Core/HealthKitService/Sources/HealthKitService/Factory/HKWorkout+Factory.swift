//
//  HKWorkout+Factory.swift
//  HealthKitService
//
//  Created by Alfonso Boizas Crespo on 20/12/25.
//

import HealthKit
import Domain

extension HKWorkout {
    
    func toDomain() -> WorkoutSession {
        let distance = totalDistance?.doubleValue(for: .meter()) ?? 0
        let duration = max(self.duration, 0)
        let speed = duration > 0 ? distance / duration : 0
        let heartRateStats = heartRateValues()
        
        return WorkoutSession(
            timestamp: startDate,
            heartRate: heartRateStats.average,
            maxHeartRate: heartRateStats.maximum,
            minHeartRate: heartRateStats.minimum,
            cadence: nil,
            speed: speed,
            distance: distance,
            totalTime: duration,
            latitude: nil,
            longitude: nil,
            sessionTrackPoints: [],
            photos: [],
            verticalOscillation: nil,
            groundContactTime: nil
        )
    }
}

// MARK: - Private methods

private extension HKWorkout {
    
    struct HeartRateValues {
        let average: Int?
        let maximum: Int?
        let minimum: Int?
    }
    
    func heartRateValues() -> HeartRateValues {
        let unit = HKUnit.count().unitDivided(by: .minute())
        let average = intValue(statisticsValue(.heartRate, unit: unit) { $0.averageQuantity() })
        let maximum = intValue(statisticsValue(.heartRate, unit: unit) { $0.maximumQuantity() })
        let minimum = intValue(statisticsValue(.heartRate, unit: unit) { $0.minimumQuantity() })
        return HeartRateValues(
            average: average,
            maximum: maximum,
            minimum: minimum
        )
    }
    
    func statisticsValue(
        _ identifier: HKQuantityTypeIdentifier,
        unit: HKUnit,
        selector: (HKStatistics) -> HKQuantity?
    ) -> Double? {
        guard let type = HKQuantityType.quantityType(forIdentifier: identifier),
              let stats = statistics(for: type),
              let quantity = selector(stats) else {
            return nil
        }
        
        return quantity.doubleValue(for: unit)
    }
    
    func intValue(_ value: Double?) -> Int? {
        guard let value else { return nil }
        return Int(value.rounded())
    }
}
