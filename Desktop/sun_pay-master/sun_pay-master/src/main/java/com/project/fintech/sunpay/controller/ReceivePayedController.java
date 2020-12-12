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
public class ReceivePayedController {
    private final RequestRepository requestRepository;

    @GetMapping("receive_payed")
    public String receivePayed(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/sign_in";
        List<Request> requestList = requestRepository.findByToAndPayIsNotNull(user);
        model.addAttribute("requestList", requestList);
        return "receive_payed_list";
    }
}
