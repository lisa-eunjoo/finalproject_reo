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
import java.util.List;

@Controller @RequiredArgsConstructor
public class ReceiveRequestController {
    private final RequestRepository requestRepository;
    private final RequestService requestService;

    @GetMapping("receive_request")
    public String receiveRequest(HttpSession session, Model model){
        User user = (User) session.getAttribute("user");
        if (user == null)return "redirect:/sign_in";
        List<Request> byFrom = requestRepository.findByFrom(user);
        model.addAttribute("receive_request_list", byFrom);
        return "receive_request_list";
    }

    @PostMapping("receive_request/refuse")
    public String refuseReceiveRequest(@RequestParam("request_id") Long id, HttpSession session){
        User user = (User) session.getAttribute("user");
        if (user == null)return "redirect:/sign_in";
        requestService.refuse(id);
        return "redirect:/receive_request";
    }
}
