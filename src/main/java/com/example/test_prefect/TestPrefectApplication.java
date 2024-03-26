package com.example.test_prefect;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan({"com.example.test_prefect.mapper", "com.example.test_prefect.controller","com.example.test_prefect.service"})//mapper가 등록된 패키지 경로 입력
@SpringBootApplication
public class TestPrefectApplication {

    public static void main(String[] args) {
        SpringApplication.run(TestPrefectApplication.class, args);
    }

}
