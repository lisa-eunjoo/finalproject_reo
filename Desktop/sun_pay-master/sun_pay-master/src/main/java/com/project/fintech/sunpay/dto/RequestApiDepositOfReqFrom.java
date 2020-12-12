package com.project.fintech.sunpay.dto;

import com.project.fintech.sunpay.model.User;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Random;

@Getter @Setter
public class RequestApiDepositOfReqFrom {

    private final String tran_no;
    private final String bank_tran_id;
    private final String fintech_use_num;
    private final String print_content;
    private final String req_client_name;
    private final String req_client_fintech_use_num;
    private final String req_client_num;
    private final String transfer_purpose;

    public RequestApiDepositOfReqFrom(String fintech_use_num, User user, Random random, int amount) {
        tran_no = "1";
        bank_tran_id = user.getUseCode() + "U" + random.nextInt(1000000000);
        this.fintech_use_num = fintech_use_num;
        print_content = String.valueOf(amount);
        req_client_name = user.getName();
        req_client_fintech_use_num = fintech_use_num;
        req_client_num = "111111111111111111";
        transfer_purpose = "ST";

    }
}
