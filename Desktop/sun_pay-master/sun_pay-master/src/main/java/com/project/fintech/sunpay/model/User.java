package com.project.fintech.sunpay.model;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@NoArgsConstructor
@Getter @Setter
public class User {

    @Id @GeneratedValue
    @Column(name = "user_id")
    private Long id;

    // 계정 이름
    private String username;

    // 계정 이름
    private String name;

    private String password;
    private int point;

    @Lob
    private String accessToken;
    private String clientKey;
    private String clientSecret;
    private String seqNum;
    private String useCode;

    // 입금용 출금용 계좌 번호 추가
    private String inputAccountNumber;
    private String outputAccountNumber;

    @Builder
    public User(String username, String name, String password, int point, String accessToken, String clientKey, String clientSecret, String seqNum, String useCode, String inputAccountNumber, String outputAccountNumber) {

        this.username = username;
        this.name = name;
        this.password = password;

        this.point = point;
        this.accessToken = accessToken;
        this.clientKey = clientKey;
        this.clientSecret = clientSecret;
        this.seqNum = seqNum;
        this.useCode = useCode;
        this.inputAccountNumber = inputAccountNumber;
        this.outputAccountNumber = outputAccountNumber;
    }
}
