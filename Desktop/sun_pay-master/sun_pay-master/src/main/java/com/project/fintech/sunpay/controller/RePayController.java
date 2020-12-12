package com.project.fintech.sunpay.controller;

import com.project.fintech.sunpay.model.Request;
import com.project.fintech.sunpay.model.User;
import com.project.fintech.sunpay.repository.RequestRepository;
import com.project.fintech.sunpay.service.RequestService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller @RequiredArgsConstructor
public class RePayController {
    private final RequestRepository requestRepository;
    private final RequestService requestService;
    @GetMapping("repay")
    public String repay(@RequestParam("request_id") Long id
            , Model model, HttpSession session){
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/sign_in";
        Request request = requestRepository.findById(id).orElseThrow(IllegalArgumentException::new);
        model.addAttribute("request", request);
        return "repay_form";
    }

    @PostMapping("repay")
    public String postRepay(@RequestParam("request_id") Long id
            , Model model, HttpSession session){
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/sign_in";
        Request request = requestService.repay(id);
        model.addAttribute("request", request);
        return "redirect:/receive_payed";
    }
}
