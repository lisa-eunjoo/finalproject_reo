package com.project.fintech.sunpay.repository;

import com.project.fintech.sunpay.model.Request;
import com.project.fintech.sunpay.model.RequestState;
import com.project.fintech.sunpay.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RequestRepository extends JpaRepository<Request, Long> {
    List<Request> findByTo(User to);

    List<Request> findByFrom(User user);
    List<Request> findByFromAndPayIsNotNull(User user);
    List<Request> findByToAndPayIsNotNull(User user);
    List<Request> findByRequestState(RequestState state);
}
