package com.project.fintech.sunpay.dto;

import lombok.Data;

import java.util.List;

@Data
public class ApiMeForm {
    private String api_tran_id;
    private String rsp_code;
    private String rsp_message;
    private String api_tran_dtm;
    private String user_seq_no;
    private String user_ci;
    private String user_name;
    private String res_cnt;
    private List<ApiMeOfResForm> res_list;

}
