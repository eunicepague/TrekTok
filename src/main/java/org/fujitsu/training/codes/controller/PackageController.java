package org.fujitsu.training.codes.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.fujitsu.training.codes.model.data.NearbyPlace;
import org.fujitsu.training.codes.model.data.TourPackage;
import org.fujitsu.training.codes.model.data.User;
import org.fujitsu.training.codes.model.data.WeatherInfo;
import org.fujitsu.training.codes.service.NearbyPlaceService;
import org.fujitsu.training.codes.service.PackageService;
import org.fujitsu.training.codes.service.WeatherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;

@Controller
public class PackageController {

	private static final Logger LOG = LogManager.getLogger(PackageController.class);

	@Autowired
	private PackageService packageService;
	
	@Autowired
	private WeatherService weatherService;
	
	@Autowired
	private NearbyPlaceService nearbyPlaceService;

	@GetMapping("/packages")
	public String showPackages(@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "type", required = false) String type,
			Model model,
			HttpSession session) {
		
		User user = (User) session.getAttribute("user");
		Integer userId = user != null ? user.getUserId() : null;
		
		List<TourPackage> records;
		
		if (keyword != null && !keyword.trim().isEmpty()) {
			String searchKeyword = keyword.trim();
			LOG.info("Package search with keyword={}, userId={}", searchKeyword, userId);
			records = packageService.searchPackages(searchKeyword);
			model.addAttribute("keyword", searchKeyword);
		} else if (type != null && !type.trim().isEmpty()) {
			String selectedType = type.trim();
			LOG.info("Package filter with type={}, userId={}", selectedType, userId);
			records = packageService.selectPackagesByType(selectedType);
			model.addAttribute("selectedType", selectedType);
		} else {
			LOG.info("Package list opened. userId={}", userId);
			records = packageService.selectAllPackages();
			Collections.shuffle(records);
		}
		
		Map<Integer, WeatherInfo> weatherMap = new HashMap<>();
		Map<Integer, List<NearbyPlace>> nearbyPlacesMap = new HashMap<>();
		
		for (TourPackage rec : records) {
			WeatherInfo currentWeather = weatherService.getCurrentWeather(rec.getLatitude(), rec.getLongitude());
			weatherMap.put(rec.getPackageId(), currentWeather);
			
			List<NearbyPlace> places = nearbyPlaceService.selectByPackageId(rec.getPackageId());
			if (places == null) {
				places = new ArrayList<>();
			}
			nearbyPlacesMap.put(rec.getPackageId(), places);
		}
		
		LOG.info("Packages loaded. userId={}, recordCount={}", userId, records.size());
		
		model.addAttribute("packages", records);
		model.addAttribute("weatherMap", weatherMap);
		model.addAttribute("nearbyPlacesMap", nearbyPlacesMap);
		return "packages";
	}
}