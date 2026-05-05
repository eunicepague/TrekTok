package org.fujitsu.training.codes.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

	private static final Logger LOG = LogManager.getLogger(HomeController.class);

	@GetMapping("/home")
	public String showHome() {
		LOG.info("Home page opened.");
		return "home";
	}
	
	
	@GetMapping("/about")
	public String showAboutPage() {
	    return "about";
	}
	
	@GetMapping("/contact")
	public String showContactPage() {
		LOG.info("Contact page opened.");
	    return "contact";
	}
}