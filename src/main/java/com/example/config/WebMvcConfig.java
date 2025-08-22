package com.example.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
    	
    	String osName = System.getProperty("os.name").toLowerCase();
    	String resourceLocation = "";
    	
    	if(osName.contains("win")) {
    		resourceLocation = "file:///C:/javaStudy/upload/";
    	}else {
    		resourceLocation ="file:/data/upload/";
    	}
    	
        registry.addResourceHandler("/upload/**")
        .addResourceLocations(resourceLocation);
        
        
    }
}
