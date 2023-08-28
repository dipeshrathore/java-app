package com.example.awsdemo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
@RequestMapping("/demo")
public class AwsDemoApplication {

	public static void main(String[] args) {
		SpringApplication.run(AwsDemoApplication.class, args);
	}

	@GetMapping()
	public String getGreeting(){
		return "Welcome to Demo !!!! spring boot application running in Docker container.";
	}

}
