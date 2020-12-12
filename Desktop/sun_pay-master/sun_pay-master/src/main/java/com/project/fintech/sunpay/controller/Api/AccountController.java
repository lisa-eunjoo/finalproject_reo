package com.project.fintech.sunpay.controller.Api;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.fintech.sunpay.model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.http.*;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequiredArgsConstructor
public class AccountController {


    // 잔액 조회 API 호출
    @GetMapping("/account")
    public String accountGet() {

        String jsonInString = "";
        HashMap<String, Object> result = new HashMap<String, Object>();

        // request url
        String url = "https://testapi.openbanking.or.kr/v2.0/account/balance/fin_num";

        try {
            // create an instance of RestTemplate
            RestTemplate restTemplate = new RestTemplate();

            // create an instance of HttpHeaders
            HttpHeaders headers = new HttpHeaders();

            // set `content-type` header
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.add("Authorization","Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiIxMTAwNzY0NjA1Iiwic2NvcGUiOlsiaW5xdWlyeSIsImxvZ2luIiwidHJhbnNmZXIiXSwiaXNzIjoiaHR0cHM6Ly93d3cub3BlbmJhbmtpbmcub3Iua3IiLCJleHAiOjE2MTExOTU4OTQsImp0aSI6IjQyOTg1MTYxLWY5ZWQtNGM1OC04OGUzLWQzMmZlNzIxNzc5MCJ9.NOYBTpdZmw1JhjalKxnDE59OUId-KhZ45UMZ5F1vwI8");


            UriComponents uri = UriComponentsBuilder.fromHttpUrl(url + "?" + "bank_tran_id=T991666420U100000002&fintech_use_num=199166642057887616752340&" +
                    "tran_dtime=20201022145100").build();

    //
            HttpEntity<String> entity = new HttpEntity<String>(headers);
            // send GET request
            ResponseEntity<Map> response = restTemplate.exchange(uri.toString(), HttpMethod.GET, entity, Map.class);

            result.put("statusCode", response.getStatusCodeValue()); //http status code를 확인
            result.put("header", response.getHeaders()); //헤더 정보 확인
            result.put("body", response.getBody()); //실제 데이터 정보 확인

            //데이터를 제대로 전달 받았는지 확인 string형태로 파싱해줌
            ObjectMapper mapper = new ObjectMapper();
            jsonInString = mapper.writeValueAsString(response.getBody());

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
