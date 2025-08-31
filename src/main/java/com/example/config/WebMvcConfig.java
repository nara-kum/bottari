package com.example.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

	private final LoginRequiredInterceptor loginRequiredInterceptor;

	public WebMvcConfig(LoginRequiredInterceptor loginRequiredInterceptor) {
		this.loginRequiredInterceptor = loginRequiredInterceptor;
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(loginRequiredInterceptor).addPathPatterns("/**").excludePathPatterns(
				// 로그인/회원 경로는 전부 제외
				"/user/**",

				// 정적/파일/에러
				"/assets/**", "/upload/**", "/favicon.ico", "/error", "/error/**", "/.well-known/**", "/manifest.json",
				"/service-worker.js", "/robots.txt", "/sitemap.xml",

				// 완전 공개 라우트만 남김
				"/shop/**", "/api/shop/**", "/api/product/**");
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		String os = System.getProperty("os.name").toLowerCase();
		String loc = os.contains("win") ? "file:///C:/javaStudy/upload/" : "file:/data/upload/";
		registry.addResourceHandler("/upload/**").addResourceLocations(loc);
	}
}
