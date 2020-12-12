package com.project.fintech.sunpay.controller;

import com.project.fintech.sunpay.model.Request;
import com.project.fintech.sunpay.model.User;
import com.project.fintech.sunpay.repository.RequestRepository;
import com.project.fintech.sunpay.service.RequestService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class RequestedController {
    private final RequestRepository requestRepository;
    private final RequestService requestService;

    @GetMapping("requested")
    public String requested(HttpSession session, Model model) {
        User to = (User) session.getAttribute("user");
        if (to == null) return "redirect:/sign_in";
        List<Request> byTo = requestRepository.findByTo(to);
        model.addAttribute("request_list", byTo);
        return "requested_list";
    }

    @PostMapping("cancel")
    public String cancel(@RequestParam("request_id") Long id, HttpSession session) {
        User to = (User) session.getAttribute("user");
        if (to == null) return "redirect:/sign_in";
        requestService.cancel(id);

        return "redirect:/requested";
    }

    @GetMapping("requested/update")
    public String requested_update(@RequestParam("request_id") Long id, Model model
            , HttpSession session) {
        User to = (User) session.getAttribute("user");
        if (to == null) return "redirect:/sign_in";
        Request request = requestRepository.findById(id).orElseThrow(IllegalArgumentException::new);
        model.addAttribute("request", request);
        return "requested_update";
    }

    @PostMapping("requested/update")
    public String post_requested_update(
            @RequestParam("request_id") Long id
            , @RequestParam("price") int price
            , @RequestParam("msg") String msg
            , @RequestParam("return_day")
              @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate returnDay
            , HttpSession session) {
        User to = (User) session.getAttribute("user");
        if (to == null) return "redirect:/sign_in";
        requestService.change(id, price, msg, returnDay);
        return "redirect:/requested";
    }

}
