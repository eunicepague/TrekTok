package org.fujitsu.training.codes.model.data;

public class PackageOption {
	private Integer optionId;
	private Integer packageId;
	private String packageName;
	private String optionName;
	private String description;
	private Double price;
	private Integer maxPax;
	private Integer availableSlots;
	private boolean usedInBookings;

	public PackageOption() {
		super();
	}

	public PackageOption(Integer optionId, Integer packageId, String packageName, String optionName, String description,
			Double price, Integer maxPax, Integer availableSlots, boolean usedInBookings) {
		super();
		this.optionId = optionId;
		this.packageId = packageId;
		this.packageName = packageName;
		this.optionName = optionName;
		this.description = description;
		this.price = price;
		this.maxPax = maxPax;
		this.availableSlots = availableSlots;
		this.usedInBookings = usedInBookings;
	}

	public Integer getOptionId() {
		return optionId;
	}

	public void setOptionId(Integer optionId) {
		this.optionId = optionId;
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

	public String getOptionName() {
		return optionName;
	}

	public void setOptionName(String optionName) {
		this.optionName = optionName;
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

	public Integer getMaxPax() {
		return maxPax;
	}

	public void setMaxPax(Integer maxPax) {
		this.maxPax = maxPax;
	}

	public Integer getAvailableSlots() {
		return availableSlots;
	}

	public void setAvailableSlots(Integer availableSlots) {
		this.availableSlots = availableSlots;
	}

	public boolean isUsedInBookings() {
		return usedInBookings;
	}

	public void setUsedInBookings(boolean usedInBookings) {
		this.usedInBookings = usedInBookings;
	}
	
	
}