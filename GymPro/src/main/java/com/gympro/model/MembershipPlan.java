package com.gympro.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Model class for gym membership plans.
 */
public class MembershipPlan {

    // Plan details
    private int planId;
    private String planName;
    private int durationMonths;

    // Pricing details
    private BigDecimal price;

    // Additional details
    private String description;
    private boolean active;
    private Timestamp createdAt;

    /**
     * Default constructor
     */
    public MembershipPlan() {
    }

    /**
     * Parameterized constructor
     */
    public MembershipPlan(int planId,
                          String planName,
                          int durationMonths,
                          BigDecimal price,
                          String description,
                          boolean active,
                          Timestamp createdAt) {

        this.planId = planId;
        this.planName = planName;
        this.durationMonths = durationMonths;
        this.price = price;
        this.description = description;
        this.active = active;
        this.createdAt = createdAt;
    }

    
    // Getter and Setter Methods
    

    public int getPlanId() {
        return planId;
    }

    public void setPlanId(int planId) {
        this.planId = planId;
    }

    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
    }

    public int getDurationMonths() {
        return durationMonths;
    }

    public void setDurationMonths(int durationMonths) {
        this.durationMonths = durationMonths;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
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

    /**
     * Checks if the plan is active.
     */
    public boolean isAvailable() {
        return active;
    }

    /**
     * Returns plan duration in readable format.
     */
    public String getDurationLabel() {

        if (durationMonths == 1) {
            return durationMonths + " Month";
        }

        return durationMonths + " Months";
    }

    /**
     * Returns formatted price text.
     */
    public String getFormattedPrice() {
        return "Rs. " + price;
    }
}
