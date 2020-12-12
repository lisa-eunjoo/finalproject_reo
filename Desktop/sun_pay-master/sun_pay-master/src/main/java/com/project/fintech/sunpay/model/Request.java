package com.project.fintech.sunpay.model;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDate;

@Entity @NoArgsConstructor
@Getter @Setter
public class Request {
    @Id @GeneratedValue
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "to_id")
    private User to;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "form_id")
    private User from;

    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "pay_id")
    private Pay pay;

    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "repay_id")
    private Repay repay;

    private int amount;
    @Lob
    private String requestMsg;

    // TODO 1주일안에 요청이 진행되지않으면 마감되는 기능추가
    // 반환하는 날과 마감용 등록날 속성 추가
    @Column(updatable = false)
    private LocalDate createDate;

    private LocalDate returnDay;

    @Enumerated(EnumType.STRING)
    private RequestState requestState;

    @Builder
    public Request(User to, User from, int amount, String requestMsg, LocalDate returnDay, RequestState requestState) {
        this.to = to;
        this.from = from;
        this.amount = amount;
        this.requestMsg = requestMsg;
        this.returnDay = returnDay;
        this.requestState = requestState;
        createDate = LocalDate.now();
    }
}