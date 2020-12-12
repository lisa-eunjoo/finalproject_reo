package com.project.fintech.sunpay.service;

import com.project.fintech.sunpay.model.*;
import com.project.fintech.sunpay.repository.RequestRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;

@Service @Transactional
@RequiredArgsConstructor
public class RequestService {
    private final RequestRepository requestRepository;
    public void cancel(Long id) {
        Request request = requestRepository.findById(id).orElseThrow(IllegalArgumentException::new);
        request.setRequestState(RequestState.CANCEL);
    }

    public void change(Long id, int amount, String msg, LocalDate returnDay) {
        Request request = requestRepository.findById(id).orElseThrow(IllegalArgumentException::new);
        request.setRequestMsg(msg);
        request.setReturnDay(returnDay);
        request.setAmount(amount);
    }

    public void refuse(Long id) {
        Request request = requestRepository.findById(id).orElseThrow(IllegalArgumentException::new);
        request.setRequestState(RequestState.REFUSE);
    }

    public void pay(Long id) {
        Request request = requestRepository.findById(id).orElseThrow(IllegalArgumentException::new);
        request.setPay(Pay.builder()
                .senderName(request.getTo().getName())
                .receiveName(request.getFrom().getName())
                .price(request.getAmount())
                .returnDay(request.getReturnDay())
                .build());
        request.setRequestState(RequestState.PAYED);
        request.getFrom().setPoint(request.getFrom().getPoint() - request.getAmount());
        request.getTo().setPoint(request.getTo().getPoint() + request.getAmount());

    }

    public Request repay(Long id) {
        Request request = requestRepository.findById(id).orElseThrow(IllegalArgumentException::new);
        Repay repay = Repay.builder()
                .price(request.getAmount())
                .receiveName(request.getFrom().getName())
                .senderName(request.getTo().getName())
                .build();
        request.setRepay(repay);
        request.setRequestState(RequestState.END);
        request.getFrom().setPoint(request.getFrom().getPoint() + request.getAmount());
        request.getTo().setPoint(request.getTo().getPoint() - request.getAmount());
        return request;
    }
}
