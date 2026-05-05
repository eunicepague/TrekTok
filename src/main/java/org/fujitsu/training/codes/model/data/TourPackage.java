package org.fujitsu.training.codes.model.data;

public class TourPackage {
	private Integer packageId;
	private String packageName;
	private String destination;
	private String description;
	private Double price;
	private String duration;
	private String imageName;
	private Integer availableSlots;
	private boolean hasOptions;
	private String weatherInfo;
	private Double latitude;
	private Double longitude;
	private String packageType;

	public TourPackage() {
		super();
	}

	public TourPackage(Integer packageId, String packageName, String destination, String description, Double price,
			String duration, String imageName, Integer availableSlots, boolean hasOptions, String weatherInfo,
			Double latitude, Double longitude, String packageType) {
		super();
		this.packageId = packageId;
		this.packageName = packageName;
		this.destination = destination;
		this.description = description;
		this.price = price;
		this.duration = duration;
		this.imageName = imageName;
		this.availableSlots = availableSlots;
		this.hasOptions = hasOptions;
		this.weatherInfo = weatherInfo;
		this.latitude = latitude;
		this.longitude = longitude;
		this.packageType = packageType;
	}

	public Integer getPackageId() {
		return packageId;
	}

	public void setPackageId(Integer packageId) {
		this.packageId = packageId;
	}

	public String getPackageName() {
		return packageName;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}

	public String getDestination() {
		return destination;
	}

	public void setDestination(String destination) {
		this.destination = destination;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public String getDuration() {
		return duration;
	}

	public void setDuration(String duration) {
		this.duration = duration;
	}

	public String getImageName() {
		return imageName;
	}

	public void setImageName(String imageName) {
		this.imageName = imageName;
	}

	public Integer getAvailableSlots() {
		return availableSlots;
	}

	public void setAvailableSlots(Integer availableSlots) {
		this.availableSlots = availableSlots;
	}

	public boolean isHasOptions() {
		return hasOptions;
	}

	public void setHasOptions(boolean hasOptions) {
		this.hasOptions = hasOptions;
	}

	public String getWeatherInfo() {
		return weatherInfo;
	}

	public void setWeatherInfo(String weatherInfo) {
		this.weatherInfo = weatherInfo;
	}

	public Double getLatitude() {
		return latitude;
	}

	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}

	public Double getLongitude() {
		return longitude;
	}

	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}

	public String getPackageType() {
		return packageType;
	}

	public void setPackageType(String packageType) {
		this.packageType = packageType;
	}
}