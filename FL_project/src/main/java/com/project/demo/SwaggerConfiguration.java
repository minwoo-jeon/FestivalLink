
package com.project.demo;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;

@Configuration
public class SwaggerConfiguration {

    @Bean
    public OpenAPI openAPI() {
        Info info = new Info()
                .version("v1.0.0")
                .title("API - swaggerTEST")
                .description("API Description");

        return new OpenAPI()
                .info(info);
    }
    
}