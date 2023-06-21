package com.project.demo;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication(exclude={SecurityAutoConfiguration.class})
@ComponentScan(basePackages={"com.project"})
@MapperScan(basePackages="com.project.mapper")
public class FlProjectApplication {

	public static void main(String[] args) {
		SpringApplication.run(FlProjectApplication.class, args);
	}

}
//testtesttesttest
