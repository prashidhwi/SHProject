package com.sh.controllers;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sh.beans.User;
import com.sh.beans.User;
import com.sh.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	ServletContext context;
	
	@RequestMapping("/form")
	public String showform(Model m) {
		m.addAttribute("command", new User());
		return "userform";
	}
	
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(@ModelAttribute("user") User user) throws Exception {
		userService.save(user);
		return "redirect:/user/view.do";// will redirect to viewuser
											// request mapping
	}
	
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String viewUser(Model m) {
		List<User> userList = userService.getUserList();
		m.addAttribute("userList", userList);
		return "viewuser";
	}
	
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String edit(@RequestParam(value = "userId") int id, Model model) {
		User user = userService.getUserById(id);
		model.addAttribute("command", user);
		return "userform";
	}
	
}
