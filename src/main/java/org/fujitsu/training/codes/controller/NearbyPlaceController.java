package org.fujitsu.training.codes.controller;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.fujitsu.training.codes.model.data.NearbyPlace;
import org.fujitsu.training.codes.model.data.TourPackage;
import org.fujitsu.training.codes.service.NearbyPlaceService;
import org.fujitsu.training.codes.service.PackageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class NearbyPlaceController {

	private static final Logger LOG = LogManager.getLogger(NearbyPlaceController.class);

	@Autowired
	private NearbyPlaceService nearbyPlaceService;

	@Autowired
	private PackageService packageService;

	@GetMapping("/admin/nearby-places")
	public String showNearbyPlaces(Model model) {
		LOG.info("Admin nearby places page opened.");

		List<NearbyPlace> records = nearbyPlaceService.selectAllNearbyPlaces();
		model.addAttribute("nearbyPlaces", records);

		LOG.info("Nearby places loaded. recordCount={}", records.size());
		return "admin/admin-nearby-places";
	}

	@GetMapping("/admin/nearby-places/add")
	public String showAddNearbyPlacePage(Model model) {
		LOG.info("Admin add nearby place page opened.");

		List<TourPackage> packages = packageService.selectAllPackages();
		model.addAttribute("packages", packages);

		return "admin/admin-add-nearby-place";
	}

	@PostMapping("/admin/nearby-places/add")
	public String processAddNearbyPlace(@RequestParam("packageId") Integer packageId,
			@RequestParam("placeName") String placeName,
	        @RequestParam("category") String category,
	        @RequestParam(value = "address", required = false) String address,
	        @RequestParam(value = "distanceKm", required = false) Double distanceKm,
	        @RequestParam(value = "mapLink", required = false) String mapLink,
	        @RequestParam(value = "latitude", required = false) Double latitude,
	        @RequestParam(value = "longitude", required = false) Double longitude,
	        Model model) {

		NearbyPlace rec = new NearbyPlace();
		rec.setPackageId(packageId);
		rec.setPlaceName(placeName == null ? null : placeName.trim());
		rec.setCategory(category == null ? null : category.trim());
		rec.setAddress(address == null ? null : address.trim());
		rec.setDistanceKm(distanceKm);
		rec.setMapLink(mapLink == null ? null : mapLink.trim());
		rec.setLatitude(latitude);
		rec.setLongitude(longitude);

		boolean saved = nearbyPlaceService.insertNearbyPlace(rec);

		if (!saved) {
			LOG.error("Nearby place insert failed. packageId={}, placeName={}", packageId, placeName);
			model.addAttribute("error", "Failed to add nearby place.");
			model.addAttribute("packages", packageService.selectAllPackages());
			model.addAttribute("rec", rec);
			return "admin/admin-add-nearby-place";
		}

		LOG.info("Nearby place inserted successfully. packageId={}, placeName={}", packageId, placeName);
		return "redirect:/admin/nearby-places";
	}

	@GetMapping("/admin/nearby-places/edit")
	public String showEditNearbyPlacePage(@RequestParam("placeId") Integer placeId,
			Model model) {

		LOG.info("Admin edit nearby place page opened. placeId={}", placeId);

		NearbyPlace rec = nearbyPlaceService.selectNearbyPlaceById(placeId);

		if (rec == null) {
			LOG.error("Nearby place not found for edit. placeId={}", placeId);
			return "redirect:/admin/nearby-places";
		}

		List<TourPackage> packages = packageService.selectAllPackages();
		model.addAttribute("packages", packages);
		model.addAttribute("rec", rec);

		return "admin/admin-edit-nearby-place";
	}

	@PostMapping("/admin/nearby-places/edit")
	public String processEditNearbyPlace(@RequestParam("placeId") Integer placeId,
			  @RequestParam("packageId") Integer packageId,
		        @RequestParam("placeName") String placeName,
		        @RequestParam("category") String category,
		        @RequestParam(value = "address", required = false) String address,
		        @RequestParam(value = "distanceKm", required = false) Double distanceKm,
		        @RequestParam(value = "mapLink", required = false) String mapLink,
		        @RequestParam(value = "latitude", required = false) Double latitude,
		        @RequestParam(value = "longitude", required = false) Double longitude,
		        Model model) {

		NearbyPlace rec = new NearbyPlace();
		rec.setPlaceId(placeId);
		rec.setPackageId(packageId);
		rec.setPlaceName(placeName == null ? null : placeName.trim());
		rec.setCategory(category == null ? null : category.trim());
		rec.setAddress(address == null ? null : address.trim());
		rec.setDistanceKm(distanceKm);
		rec.setMapLink(mapLink == null ? null : mapLink.trim());
		rec.setLatitude(latitude);
		rec.setLongitude(longitude);

		boolean updated = nearbyPlaceService.updateNearbyPlace(rec);

		if (!updated) {
			LOG.error("Nearby place update failed. placeId={}", placeId);
			model.addAttribute("error", "Failed to update nearby place.");
			model.addAttribute("packages", packageService.selectAllPackages());
			model.addAttribute("rec", rec);
			return "admin/admin-edit-nearby-place";
		}

		LOG.info("Nearby place updated successfully. placeId={}", placeId);
		return "redirect:/admin/nearby-places";
	}

	@PostMapping("/admin/nearby-places/delete")
	public String deleteNearbyPlace(@RequestParam("placeId") Integer placeId) {
		LOG.info("Delete nearby place attempt. placeId={}", placeId);

		boolean deleted = nearbyPlaceService.deleteNearbyPlace(placeId);

		if (deleted) {
			LOG.info("Nearby place deleted successfully. placeId={}", placeId);
		} else {
			LOG.error("Nearby place delete failed. placeId={}", placeId);
		}

		return "redirect:/admin/nearby-places";
	}
}