package com.project.fintech.sunpay.controller;

import com.project.fintech.sunpay.model.User;
import com.project.fintech.sunpay.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
public class SignController {
    private final UserRepository userRepository;
    @GetMapping("sign_in")
    public String sign_in_form(Model model){
        model.addAttribute("user", new User());
        return "sign_in_form";
    }

    @PostMapping("sign_in")
    public String sign_in(
            @RequestParam(name = "username") String username
            , @RequestParam(name = "password") String password
            , HttpSession session){
        User findUser = userRepository
                .findByUsernameAndPassword(username, password).orElseThrow(IllegalArgumentException::new);
        session.setAttribute("user", findUser);
        return "redirect:/request";
    }


}
