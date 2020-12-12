package com.project.fintech.sunpay.controller;

import com.project.fintech.sunpay.model.Request;
import com.project.fintech.sunpay.model.User;
import com.project.fintech.sunpay.repository.RequestRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class PayedController {
    private final RequestRepository requestRepository;
    @GetMapping("payed")
    public String payed(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/sign_in";
        List<Request> requestList = requestRepository.findByFromAndPayIsNotNull(user);
        model.addAttribute("request_list", requestList);
        return "payed_list";
    }
}
