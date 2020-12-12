package com.project.fintech.sunpay.model;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity @NoArgsConstructor
@Getter
public class Pay {
    @Id @GeneratedValue
    @Column(name = "pay_id")
    private Long id;
    private LocalDateTime payDay;
    private LocalDate returnDay;
    private int price;
    private String senderName;
    private String receiveName;

    @Builder
    public Pay(LocalDate returnDay, int price, String senderName, String receiveName) {
        payDay = LocalDateTime.now();
        this.returnDay = returnDay;
        this.price = price;
        this.senderName = senderName;
        this.receiveName = receiveName;
    }
}
