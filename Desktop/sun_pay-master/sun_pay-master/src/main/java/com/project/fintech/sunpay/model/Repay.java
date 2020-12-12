package com.project.fintech.sunpay.model;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.time.LocalDateTime;

@Entity @NoArgsConstructor
@Getter
public class Repay {
    @Id @GeneratedValue
    @Column(name = "repay_id")
    private Long id;
    private LocalDateTime payDay;
    private int price;
    private String senderName;
    private String receiveName;

    @Builder
    public Repay( int price, String senderName, String receiveName) {
        this.payDay = LocalDateTime.now();
        this.price = price;
        this.senderName = senderName;
        this.receiveName = receiveName;
    }
}
