package com.project.demo;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;


@SpringBootApplication(exclude= {SecurityAutoConfiguration.class})
@EntityScan("com.project.domain")
@MapperScan(basePackages= {"com.project.mapper"})
@ComponentScan(basePackages= {"com.project"})
public class FlProjectApplication {

	public static void main(String[] args) {
		SpringApplication.run(FlProjectApplication.class, args);
	}

}
//testtesttesttest
