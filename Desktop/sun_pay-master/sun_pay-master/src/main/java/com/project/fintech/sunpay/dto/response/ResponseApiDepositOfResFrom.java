package com.project.fintech.sunpay.dto.response;

import lombok.Data;

@Data
public class ResponseApiDepositOfResFrom {
    private String tran_no;
    private String bank_tran_id;
    private String bank_tran_date;
    private String bank_code_tran;
    private String bank_rsp_code;
    private String bank_rsp_message;
    private String bank_code_std;
    private String bank_code_sub;
    private String bank_name;
    private String account_num;
    private String account_num_masked;
    private String print_content;
    private String account_holder_name;
    private String tran_amt;
}
