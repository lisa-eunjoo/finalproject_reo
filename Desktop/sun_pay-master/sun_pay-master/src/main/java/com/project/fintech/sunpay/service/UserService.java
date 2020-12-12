package com.project.fintech.sunpay.service;

import com.project.fintech.sunpay.model.User;
import com.project.fintech.sunpay.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service @Transactional
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;

    public void out(User user, int amount) {
        user = userRepository.findById(user.getId()).orElseThrow(IllegalArgumentException::new);
        user.setPoint(user.getPoint() - amount);
    }
    public void in(User user, int amount) {
        user = userRepository.findById(user.getId()).orElseThrow(IllegalArgumentException::new);
        user.setPoint(user.getPoint() + amount);
    }
}
