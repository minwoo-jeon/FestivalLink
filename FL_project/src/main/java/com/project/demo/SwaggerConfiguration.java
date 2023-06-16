
package com.project.demo;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;

//
//import java.util.HashSet;
//import java.util.Set;
//
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//
//import springfox.documentation.builders.ApiInfoBuilder;
//import springfox.documentation.builders.PathSelectors;
//import springfox.documentation.builders.RequestHandlerSelectors;
//import springfox.documentation.service.ApiInfo;
//import springfox.documentation.spi.DocumentationType;
//import springfox.documentation.spring.web.plugins.Docket;
//import springfox.documentation.swagger2.annotations.EnableSwagger2;
//
//@Configuration
//@EnableSwagger2
//public class SwaggerConfiguration {
//	
//	private ApiInfo apiInfo() {
//		return new ApiInfoBuilder()
//			.title("Demo")
//			.description("API EXAMPLE")
//			.version("1.0")
//			.build();
//	}
//	
//	private Set<String> getConsumeContentTypes() {
//		Set<String> consumes = new HashSet<>();
//		consumes.add("application/json;charset=UTF-8");
//		consumes.add("application/x-www-form-urlencoded");
//		return consumes;
//	}
//	
//	private Set<String> getProduceContentTypes() {
//		Set<String> produces = new HashSet<>();
//		produces.add("application/json;charset=UTF-8");
//		return produces;
//	}
//	
//	@Bean
//	public Docket commonApi() {
//		return new Docket(DocumentationType.SWAGGER_2)
//				.consumes(getConsumeContentTypes())
//				.produces(getProduceContentTypes())
//				.apiInfo(apiInfo())
//				.select()
//				.apis(RequestHandlerSelectors.any())
//				.paths(PathSelectors.ant("/api/**"))
//				.build();
//	}
//
//}

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