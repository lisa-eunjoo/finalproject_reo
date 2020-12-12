package com.project.fintech.sunpay.controller.Api;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.util.JSONPObject;
import com.project.fintech.sunpay.model.User;
import com.project.fintech.sunpay.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.json.JSONObject;
import org.springframework.http.*;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import java.nio.charset.Charset;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequiredArgsConstructor
public class TransferController {

    // 출금 이제 API 호출
    @PostMapping("/transfer")
    public String doTransfer(){
        String url = "https://testapi.openbanking.or.kr/v2.0/transfer/withdraw/fin_num";
        String jsonInString = "";
        HashMap<String, Object> result = new HashMap<String, Object>();

        try {
            RestTemplate restTemplate = new RestTemplate();
            HttpHeaders headers = new HttpHeaders();
    //        httpheaders.add("Content-Type", "application/json; charset=UTF-8");

            // set `accept` header
    //        httpheaders.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
            SimpleClientHttpRequestFactory requestFactory = new SimpleClientHttpRequestFactory();

            requestFactory.setConnectTimeout(7000); // set short connect timeout
            requestFactory.setReadTimeout(7000); // set slightly longer read timeout
            restTemplate.setRequestFactory(requestFactory);

            // set `content-type` header
//            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.add("Content-Type", "application/json; charset=UTF-8");
            headers.add("Authorization","Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiIxMTAwNzY0NjA1Iiwic2NvcGUiOlsiaW5xdWlyeSIsImxvZ2luIiwidHJhbnNmZXIiXSwiaXNzIjoiaHR0cHM6Ly93d3cub3BlbmJhbmtpbmcub3Iua3IiLCJleHAiOjE2MTExOTU4OTQsImp0aSI6IjQyOTg1MTYxLWY5ZWQtNGM1OC04OGUzLWQzMmZlNzIxNzc5MCJ9.NOYBTpdZmw1JhjalKxnDE59OUId-KhZ45UMZ5F1vwI8");

            long ranNum = Math.round(Math.random() * 1000000000);
            String bank_tran_id = "T991666420U" + ranNum;
            System.out.println(bank_tran_id);

            Map<String, String> jsonObject = new HashMap<>();
            jsonObject.put("cntr_account_type", "N");
            jsonObject.put("bank_tran_id", bank_tran_id);
            jsonObject.put("cntr_account_num", "5999104037");
            jsonObject.put("dps_print_content", "쇼핑몰환불");
            jsonObject.put("fintech_use_num", "199166642057887616752340");
            jsonObject.put("wd_print_content", "오픈뱅킹출금");
            jsonObject.put("tran_amt", "1000");
            jsonObject.put("tran_dtime", "20201023110700");
            jsonObject.put("req_client_name", "홍길동");
            jsonObject.put("req_client_num", "HONGGILDONG1111");
            jsonObject.put("req_client_fintech_use_num", "199166642057887616744788");
            jsonObject.put("transfer_purpose", "ST");
            jsonObject.put("recv_client_name", "김태호");
            jsonObject.put("recv_client_bank_code", "097");
            jsonObject.put("recv_client_account_num", "5999104037");

            UriComponents uri = UriComponentsBuilder.fromHttpUrl(url
                        ).build();
//                    + "?" + "cntr_account_type=N&"
//                    + "bank_tran_id=T991666420U000001018" +
//                    "&cntr_account_type=N&cntr_account_num=5999104037&dps_print_content=쇼핑몰환불" +
//                    "&fintech_use_num=199166642057887616752340&wd_print_content=오픈뱅킹출금&tran_amt=1000" +
//                    "&tran_dtime=20201023110700&req_client_name=홍길동&req_client_num=HONGGILDONG1111" +
//                    "&req_client_fintech_use_num=199166642057887616752340&transfer_purpose=ST&recv_client_name=김태호" +
//                    "&recv_client_bank_code=097&recv_client_account_num=5999104037").build();

            System.out.println(uri.toString());

            // build the request
            HttpEntity<Map<String, String>> entity = new HttpEntity<>(jsonObject, headers);

            // send POST request
//            ResponseEntity<String> response = restTemplate.postForEntity(url, entity, String.class);
            ResponseEntity<Map> response = restTemplate.exchange(uri.toString(), HttpMethod.POST, entity, Map.class);

            result.put("statusCode", response.getStatusCodeValue()); //http status code를 확인
            result.put("header", response.getHeaders()); //헤더 정보 확인
            result.put("body", response.getBody()); //실제 데이터 정보 확인

            //데이터를 제대로 전달 받았는지 확인 string형태로 파싱해줌
            ObjectMapper mapper = new ObjectMapper();
            jsonInString = mapper.writeValueAsString(response.getBody());
        // check response
        } catch (HttpClientErrorException | HttpServerErrorException e) {
            result.put("statusCode", e.getRawStatusCode());
            result.put("body", e.getStatusText());
            System.out.println("dfdfdfdf");
            System.out.println(e.toString());

        } catch (Exception e) {
            result.put("statusCode", "999");
            result.put("body", "excpetion오류");
            System.out.println(e.toString());
        }

        return jsonInString;
    }

}
