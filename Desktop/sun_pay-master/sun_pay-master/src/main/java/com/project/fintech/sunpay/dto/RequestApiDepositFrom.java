package com.project.fintech.sunpay.dto;

import com.project.fintech.sunpay.model.User;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Getter
@Setter
public class RequestApiDepositFrom {
    private final String tran_dtime;
    private final String req_cnt;
    private String name_check_option;
    private String cntr_account_num;
    private String wd_pass_phrase;
    private List<RequestApiDepositOfReqFrom> req_list= new ArrayList<>();
    public RequestApiDepositFrom(User user, String fintech_use_num, Random random, int amount) {
        cntr_account_num = user.getInputAccountNumber();
        wd_pass_phrase = "NONE";
        name_check_option = "on";
        tran_dtime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        req_cnt = "1";
        req_list.add(new RequestApiDepositOfReqFrom(fintech_use_num,user,random,amount));
    }
}
