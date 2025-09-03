package com.example.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.RedirectViewControllerRegistration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    private final LoginRequiredInterceptor loginRequiredInterceptor;
    
    // file.upload-dir 값을 프로퍼티에서 주입 (프로필별로 값이 달라짐)
    @Value("${file.upload-dir}")
    private String uploadDir; // 예) "C:/javaStudy/upload" 또는 "/data/upload"

    public WebMvcConfig(LoginRequiredInterceptor loginRequiredInterceptor) {
        this.loginRequiredInterceptor = loginRequiredInterceptor;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(loginRequiredInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns(
                        // 로그인/회원
                        "/user/**",

                        // 정적/파일/에러
                        "/assets/**", "/upload/**", "/favicon.ico",
                        "/error", "/error/**", "/.well-known/**",
                        "/manifest.json", "/service-worker.js",
                        "/robots.txt", "/sitemap.xml",

                        // 공유 초대장 "뷰"만 공개
                        "/invitation/invitation", "/invitation/invitation/**",

                        // 라우팅·공유·상품 페이지(뷰)
                        "/r/**",
                        "/i/**", "/share/**", "/kakao/**",
                        
//						"/shop/**"
						// 공개로 열어둘 페이지만 지정 (예시)
						"/shop/bottarimall",
						"/shop/productPage2",        // productPage2는 인터셉터 특례 있음
						"/shop/product/**"           // 필요 시
                );
    }

    
    @Override // 정적 리소스 핸들러 등록
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String p = uploadDir.replace("\\", "/");               // 윈도우 호환
        if (!p.endsWith("/")) p = p + "/";                     // 끝 슬래시 보장
        String loc = p.startsWith("file:") ? p : "file:" + p;  // file: 접두사 부여

        registry.addResourceHandler("/upload/**")              // 브라우저 경로
                .addResourceLocations(loc)                     // 실제 파일 위치
                .setCachePeriod(3600);                         // 선택: 캐시
    }
    

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        RedirectViewControllerRegistration r1 =
                registry.addRedirectViewController("/loginForm", "/user/loginForm");
        r1.setKeepQueryParams(true);

        RedirectViewControllerRegistration r2 =
                registry.addRedirectViewController("/loginform", "/user/loginForm");
        r2.setKeepQueryParams(true);

        RedirectViewControllerRegistration r3 =
                registry.addRedirectViewController("/user/loginform", "/user/loginForm");
        r3.setKeepQueryParams(true);
    }
}
