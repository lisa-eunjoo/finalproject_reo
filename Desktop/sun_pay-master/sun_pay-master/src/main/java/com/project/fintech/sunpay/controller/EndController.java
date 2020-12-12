package com.project.fintech.sunpay.controller;

import com.project.fintech.sunpay.model.Request;
import com.project.fintech.sunpay.model.RequestState;
import com.project.fintech.sunpay.model.User;
import com.project.fintech.sunpay.repository.RequestRepository;
import com.project.fintech.sunpay.service.RequestService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class EndController {
    private final RequestRepository requestRepository;
    private final RequestService requestService;
    @GetMapping("end")
    public String end(Model model, HttpSession session){
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/sign_in";
        List<Request> requestList = requestRepository.findByRequestState(RequestState.END);
        model.addAttribute("requestList", requestList);
        return "end_list";
    }
}
