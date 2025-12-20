//
//  AppleHealthImportDelegate.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 20/12/25.
//

@MainActor
public protocol AppleHealthImportDelegate: AnyObject {
    func didImportNewWorkout()
}
