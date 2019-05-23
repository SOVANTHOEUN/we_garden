package com.wegarden.web.model;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class CountTotalIncome {
    @Id
    @JsonProperty("credit_income")
    private Double creditIncome;

    @JsonProperty("cash_income")
    private Double cashIncome;

    @JsonProperty("debt_income")
    private Double debtIncome;

    @JsonProperty("bronze_master_income")
    private Double bronzeMasterIncome;

    @JsonProperty("tea_time_income")
    private Double teaTimeIncome;

    public CountTotalIncome() { }

    public CountTotalIncome(Double creditIncome, Double cashIncome, Double debtIncome, Double bronzeMasterIncome, Double teaTimeIncome) {
        this.creditIncome = creditIncome;
        this.cashIncome = cashIncome;
        this.debtIncome = debtIncome;
        this.bronzeMasterIncome = bronzeMasterIncome;
        this.teaTimeIncome = teaTimeIncome;
    }

    public Double getCreditIncome() {
        return creditIncome;
    }

    public void setCreditIncome(Double creditIncome) {
        this.creditIncome = creditIncome;
    }

    public Double getCashIncome() {
        return cashIncome;
    }

    public void setCashIncome(Double cashIncome) {
        this.cashIncome = cashIncome;
    }

    public Double getDebtIncome() {
        return debtIncome;
    }

    public void setDebtIncome(Double debtIncome) {
        this.debtIncome = debtIncome;
    }

    public Double getBronzeMasterIncome() {
        return bronzeMasterIncome;
    }

    public void setBronzeMasterIncome(Double bronzeMasterIncome) {
        this.bronzeMasterIncome = bronzeMasterIncome;
    }

    public Double getTeaTimeIncome() {
        return teaTimeIncome;
    }

    public void setTeaTimeIncome(Double teaTimeIncome) {
        this.teaTimeIncome = teaTimeIncome;
    }

    @Override
    public String toString() {
        return "CountTotalIncome{" +
                "creditIncome=" + creditIncome +
                ", cashIncome=" + cashIncome +
                ", debtIncome=" + debtIncome +
                ", bronzeMasterIncome=" + bronzeMasterIncome +
                ", teaTimeIncome=" + teaTimeIncome +
                '}';
    }
}
