package com.project.fintech.sunpay.repository;

import com.project.fintech.sunpay.model.Friend;
import com.project.fintech.sunpay.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FriendRepository extends JpaRepository<Friend, Long> {
    List<Friend> findByTo(User user);

    boolean existsByToAndFrom(User to, User from);
}
