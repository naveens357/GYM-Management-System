package com.gympro.model;

import java.sql.Timestamp;

/**
 * Model class for gym classes/sessions.
 */
public class GymClass {

    // Class details
    private int classId;
    private String className;
    private int trainerId;

    // Schedule details
    private Timestamp scheduleDatetime;
    private int durationMinutes;

    // Capacity details
    private int capacity;
    private int enrolledCount;

    // Additional details
    private String description;
    private boolean active;
    private Timestamp createdAt;

    // Joined field from trainer table
    private String trainerName;

    /**
     * Default constructor
     */
    public GymClass() {
    }

    
    // Getter and Setter Methods

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public int getTrainerId() {
        return trainerId;
    }

    public void setTrainerId(int trainerId) {
        this.trainerId = trainerId;
    }

    public Timestamp getScheduleDatetime() {
        return scheduleDatetime;
    }

    public void setScheduleDatetime(Timestamp scheduleDatetime) {
        this.scheduleDatetime = scheduleDatetime;
    }

    public int getDurationMinutes() {
        return durationMinutes;
    }

    public void setDurationMinutes(int durationMinutes) {
        this.durationMinutes = durationMinutes;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public int getEnrolledCount() {
        return enrolledCount;
    }

    public void setEnrolledCount(int enrolledCount) {
        this.enrolledCount = enrolledCount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getTrainerName() {
        return trainerName;
    }

    public void setTrainerName(String trainerName) {
        this.trainerName = trainerName;
    }

    /**
     * Returns available seats/spots.
     */
    public int getAvailableSpots() {
        return capacity - enrolledCount;
    }

    /**
     * Checks if class is full.
     */
    public boolean isClassFull() {
        return enrolledCount >= capacity;
    }

    /**
     * Checks if class is available for booking.
     */
    public boolean isAvailable() {
        return active && !isClassFull();
    }
}
