package com.project.fintech.sunpay.controller;

import com.project.fintech.sunpay.dto.*;
import com.project.fintech.sunpay.dto.withdraw.RequestApiWithdrawFrom;
import com.project.fintech.sunpay.dto.withdraw.ResponseApiWithdrawFrom;
import com.project.fintech.sunpay.model.User;
import com.project.fintech.sunpay.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;

@Controller @RequiredArgsConstructor
public class ApiController {
    private final UserService userService;
    private Random random = new Random();
    private WebClient webClient = WebClient.create();

    @GetMapping("me_in")
    public String meIn(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/sign_in";
        ApiMeForm me = getMe(user);
        model.addAttribute("me", me);
        return "me_in_list";
    }

    @GetMapping("me_out")
    public String meOut(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/sign_in";
        ApiMeForm me = getMe(user);
        model.addAttribute("me", me);
        return "me_out_list";
    }

    private ApiMeForm getMe(User user) {
        Mono<ApiMeForm> apiMeForm = webClient
                .mutate()
                .baseUrl("https://testapi.openbanking.or.kr").build()
                .get()
                .uri(it ->
                        it.path("/v2.0/user/me")
                                .queryParam("user_seq_no", user.getSeqNum()).build())
                .header("Authorization", "bearer " + user.getAccessToken())
                .retrieve()
                .bodyToMono(ApiMeForm.class);
        ApiMeForm form = apiMeForm.block();
        return form;
    }

    @GetMapping("balance_in")
    public String balance_in(@RequestParam("fintech_use_num")String fintech_use_num
                          ,Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/sign_in";
        ApiBalanceForm balance = getBalance(fintech_use_num, user);
        model.addAttribute("balance", balance);
        return "balance_in";
    }
    @GetMapping("balance_out")
    public String balance_out(@RequestParam("fintech_use_num")String fintech_use_num
            ,Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/sign_in";
        ApiBalanceForm balance = getBalance(fintech_use_num, user);
        model.addAttribute("balance", balance);
        return "balance_out";
    }

    private ApiBalanceForm getBalance(String fintech_use_num, User user) {
        Mono<ApiBalanceForm> apiBalanceFormMono = webClient.mutate()
                .baseUrl("https://testapi.openbanking.or.kr").build()
                .get()
                .uri(it ->
                        it
                                .path("/v2.0/account/balance/fin_num")
                                .queryParam("tran_dtime", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")))
                                .queryParam("fintech_use_num", fintech_use_num)
                                .queryParam("bank_tran_id", user.getUseCode() + "U" + random.nextInt(1000000000))
                                .build())
                .header("Authorization", "Bearer " + user.getAccessToken())
                .retrieve()
                .bodyToMono(ApiBalanceForm.class);
        ApiBalanceForm balance = apiBalanceFormMono.block();
        return balance;
    }

    @PostMapping("withdraw")
    public String withdraw(
            @RequestParam("amount")int amount
            ,@RequestParam("fintech_use_num")String fintech_use_num
            ,Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/sign_in";
        Mono<ResponseApiWithdrawFrom> responseApiWithdrawFromMono = webClient.mutate()
                .baseUrl("https://testapi.openbanking.or.kr").build()
                .post()
                .uri("/v2.0/transfer/withdraw/fin_num")
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + user.getAccessToken())
                .bodyValue(new RequestApiWithdrawFrom(user, fintech_use_num, random, amount))
                .retrieve()
                .bodyToMono(ResponseApiWithdrawFrom.class);
        ResponseApiWithdrawFrom withdraw = responseApiWithdrawFromMono.block();
         model.addAttribute("withdraw", withdraw);
        userService.out(user, amount);
        return "redirect:/request";
    }

    @PostMapping("deposit")
    public String deposit(
            @RequestParam("amount")int amount
            ,@RequestParam("fintech_use_num") String fintech_use_num
            ,Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/sign_in";
        RequestApiDepositFrom body = new RequestApiDepositFrom(user, fintech_use_num, random, amount);
        Mono<String> responseApiWithdrawFromMono = webClient.mutate()
                .baseUrl("https://testapi.openbanking.or.kr").build()
                .post()
                .uri("/v2.0/transfer/deposit/fin_num")
                .header("Authorization", "Bearer " + user.getAccessToken())
                .contentType(MediaType.APPLICATION_JSON)
                .accept(MediaType.APPLICATION_JSON)
//                .bodyValue(body)
                .bodyValue(body)
                .retrieve()
                .bodyToMono(String.class);
        System.out.println(responseApiWithdrawFromMono.block());
//        ResponseApiDepositFrom deposit = responseApiWithdrawFromMono.block();
//        model.addAttribute("deposit", deposit);
        userService.in(user, amount);
        return "redirect:/request";
    }


}
