package com.project.fintech.sunpay;


import com.project.fintech.sunpay.model.Friend;
import com.project.fintech.sunpay.model.Request;
import com.project.fintech.sunpay.model.RequestState;
import com.project.fintech.sunpay.model.User;
import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Component
@RequiredArgsConstructor
public class InitDate {
    private final InitService initService;

    @PostConstruct
    public void init() {
        initService.init();
    }

    @Component
    static class InitService {
        @PersistenceContext
        private EntityManager em;
        private String[] names = {"구태균", "김태호", "이은주"};
        private int[] pointList = {1000, 2000, 3000};
        private int[] payList = {10, 20, 30, 40, 50};

        @Transactional
        public void init() {
            User koo = User.builder()
                    .name(names[0])
                    .point(pointList[0])
                    .password("p")
                    .username("user" + 1)
                    .clientKey("d6NED6UBY37jD74AldxE3efJ5a0lDQXWr6y7lAVI")
                    .clientSecret("9jhDrk9ZQpO3SvaB0ixr96DA4qBQNdUDwwbkKXvB")
                    .seqNum("1100764619")
                    .accessToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiIxMTAwNzY0NjE5Iiwic2NvcGUiOlsiaW5xdWlyeSIsImxvZ2luIiwidHJhbnNmZXIiXSwiaXNzIjoiaHR0cHM6Ly93d3cub3BlbmJhbmtpbmcub3Iua3IiLCJleHAiOjE2MTE3ODEzNTcsImp0aSI6IjgxMTI1ZjllLTY3ZGEtNDk1NC04MjJlLTViM2NkYjE1NzExNCJ9.f2c8TYApuPO80gJr5OdRIo0JRWbS5NycO5QpW28MnQE")
                    .useCode("T991666290")
                    .inputAccountNumber("9818742028")
                    .outputAccountNumber("0867087549")
                    .build();
            em.persist(koo);
            // 김태호님 빈 값 채우기
            User kim = User.builder()
                    .name(names[1])
                    .point(pointList[1])
                    .password("p")
                    .username("user" + 2)
                    .clientKey("Rj7CCiU8NG5ehew2pYWZtT1zplsRIxeDxFcASc23")
                    .clientSecret("dLXfdAkxiKAGoatI302XPV25B7dCYcdZmmAHUvOW")
                    .seqNum("1100764605")
                    .accessToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiIxMTAwNzY0NjA1Iiwic2NvcGUiOlsiaW5xdWlyeSIsImxvZ2luIiwidHJhbnNmZXIiXSwiaXNzIjoiaHR0cHM6Ly93d3cub3BlbmJhbmtpbmcub3Iua3IiLCJleHAiOjE2MTExOTU4OTQsImp0aSI6IjQyOTg1MTYxLWY5ZWQtNGM1OC04OGUzLWQzMmZlNzIxNzc5MCJ9.NOYBTpdZmw1JhjalKxnDE59OUId-KhZ45UMZ5F1vwI8.eyJhdWQiOiIxMTAwNzY0NjE5Iiwic2NvcGUiOlsiaW5xdWlyeSIsImxvZ2luIiwidHJhbnNmZXIiXSwiaXNzIjoiaHR0cHM6Ly93d3cub3BlbmJhbmtpbmcub3Iua3IiLCJleHAiOjE2MTE2NTE0MDQsImp0aSI6IjRmMTQ4ZTkyLTM3NTMtNDFjNy1hODYxLWE0Y2M5MzMzZGUxNiJ9.8mnMai6OTzPIx9wXDleXRrzQu8YkUu9pivFIMA4a7xg")
                    .useCode("T991666420")
                    .inputAccountNumber("0002512655")
                    .outputAccountNumber("5999104037")
                    .build();
            em.persist(kim);
            // TODO 이은주님 빈 값 채우기
            User lee = User.builder()
                    .name(names[2])
                    .point(pointList[2])
                    .password("p")
                    .username("user" + 3)
                    .clientKey("mkTKJ5HyW99zSPXcwnR65K2UT6ZUBAVyQxiZaJkd")
                    .clientSecret("UNTXWPsLaEzDKz5vPvyLHVVudgeAju1Ot9Lje0Bf")
                    .seqNum("")
                    .accessToken("")
                    .useCode("")
                    .build();
            em.persist(lee);

            // 친구 관계 추가
            processFriend(koo, kim);
            processFriend(koo, lee);
            processFriend(kim, lee);

            // 요청 데이터 추가
            processRequest(koo, kim);
        }

        private void processRequest(User koo, User kim) {
            for (int i = 0; i < payList.length; i++) {
                em.persist(Request.builder()
                        .to(kim)
                        .from(koo)
                        .amount(payList[i])
                        .requestState(RequestState.READ)
                        .returnDay(LocalDate.now().plusDays(30))
                        // TODO 제대로된 메시지 내용으로 교체하기
                        .requestMsg("메시지 내용")
                        .build());
            }


        }

        private void processFriend(User user1, User user2) {
            em.persist(Friend.builder()
                    .to(user1)
                    .from(user2)
                    .build());

            em.persist(Friend.builder()
                    .to(user2)
                    .from(user1)
                    .build());

        }
    }
}