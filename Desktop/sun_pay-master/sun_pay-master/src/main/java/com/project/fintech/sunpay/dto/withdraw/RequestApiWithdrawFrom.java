package com.project.fintech.sunpay.dto.withdraw;

import com.project.fintech.sunpay.model.User;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;

@NoArgsConstructor
@Getter
@Setter
public class RequestApiWithdrawFrom {
    private String bank_tran_id;
    private String cntr_account_type;
    private String cntr_account_num;
    private String dps_print_content;
    private String fintech_use_num;
    private String wd_print_content;
    private String tran_amt;
    private String tran_dtime;
    private String req_client_name;
    private String req_client_num;
    private String req_client_fintech_use_num;
    private String transfer_purpose;
    private String recv_client_name;
    private String recv_client_bank_code;
    private String recv_client_account_num;

    public RequestApiWithdrawFrom(User user, String fintech_use_num, Random random, int amount) {
        bank_tran_id = user.getUseCode() + "U" + random.nextInt(1000000000);
        cntr_account_type = "N";
        cntr_account_num = user.getOutputAccountNumber();
        dps_print_content = "출금";
        this.fintech_use_num = fintech_use_num;
        wd_print_content = "오픈뱅킹출금";
        tran_amt = String.valueOf(amount);
        tran_dtime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        req_client_name = user.getName();
        req_client_fintech_use_num = fintech_use_num;
        req_client_num = "HONGGILDONG1234";
        transfer_purpose = "TR";
        recv_client_name = user.getName();
        recv_client_bank_code = "097";
        recv_client_account_num = user.getOutputAccountNumber();
    }
}
