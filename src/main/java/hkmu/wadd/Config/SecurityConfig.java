package hkmu.wadd.Config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

import static org.springframework.security.config.Customizer.withDefaults;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http)
            throws Exception {
        http
                .authorizeHttpRequests(authorize -> authorize
                        .requestMatchers("/user/create", "/user/create/**").permitAll()
                        .requestMatchers("/user/edit").authenticated()
                        .requestMatchers("/poll/create", "/poll/create/**", "/poll/delete/**","/poll/edit/**","/comment/delete/**").hasRole("ADMIN")
                        .requestMatchers("/poll/history").authenticated()
                        .requestMatchers("/user/comments").authenticated()
                        .requestMatchers("/poll/**").hasAnyRole("USER", "ADMIN")
                        .requestMatchers("/user/**").hasRole("ADMIN")
                        .requestMatchers("/course/delete/**").hasRole("ADMIN")
                        .requestMatchers("/course/**").hasAnyRole("USER", "ADMIN")
                        .requestMatchers(HttpMethod.POST, "/course/view/**/comment").authenticated()
                        .anyRequest().permitAll()
                )
                .formLogin(form -> form
                        .loginPage("/login")
                        .failureUrl("/login?error")
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/login?logout")
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID")
                )
                .rememberMe(remember -> remember
                        .key("uniqueAndSecret")
                        .tokenValiditySeconds(86400)
                )
                .httpBasic(withDefaults());
        return http.build();
    }
}