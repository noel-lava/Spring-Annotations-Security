package com.jlava.service.security;

import java.util.ArrayList;
import java.util.List;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
 
import com.jlava.model.User;
import com.jlava.model.UserRole;
import com.jlava.service.UserService;

@Service
public class CustomUserDetailsService implements UserDetailsService{
	@Autowired
	UserService userService;

	@Transactional(readOnly=true)
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userService.getUser(username);
        if(user==null){
            System.out.println("User not found");
            throw new UsernameNotFoundException("User " + username + " not found");
        }
        
        boolean valid = user.isDeleted()?false:true;
        org.springframework.security.core.userdetails.User authUser = new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(), 
                valid, true, true, true, getGrantedAuthorities(user));
        System.out.println("AUTH USER : " + authUser.getUsername());

        return authUser;
    }
 
    private List<GrantedAuthority> getGrantedAuthorities(User user){
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
         
        for(UserRole userRole : user.getUserRoles()){
            System.out.println("UserRole : " + userRole.getType());
            authorities.add(new SimpleGrantedAuthority("ROLE_" + userRole.getType()));
        }
        System.out.println("authorities : " + authorities);
        return authorities;
    }
}