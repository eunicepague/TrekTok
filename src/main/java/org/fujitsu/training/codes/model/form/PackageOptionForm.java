package org.fujitsu.training.codes.model.form;

public class PackageOptionForm {
	private Integer optionId; // Stores package option ID
	private Integer packageId; // Stores related package ID
	private String optionName; // Stores option name
	private String description; // Stores option description
	private Double price; // Stores option price
	private Integer maxPax; // Stores maximum number of people
	private Integer availableSlots; // Stores available slots for this option

	public PackageOptionForm() {
		super(); // Default constructor
	}

	public Integer getOptionId() {
		return optionId; // Returns option ID
	}

	public void setOptionId(Integer optionId) {
		this.optionId = optionId; // Sets option ID
	}

	public Integer getPackageId() {
		return packageId; // Returns package ID
	}

	public void setPackageId(Integer packageId) {
		this.packageId = packageId; // Sets package ID
	}

	public String getOptionName() {
		return optionName; // Returns option name
	}

	public void setOptionName(String optionName) {
		this.optionName = optionName; // Sets option name
	}

	public String getDescription() {
		return description; // Returns description
	}

	public void setDescription(String description) {
		this.description = description; // Sets description
	}

	public Double getPrice() {
		return price; // Returns price
	}

	public void setPrice(Double price) {
		this.price = price; // Sets price
	}

	public Integer getMaxPax() {
		return maxPax; // Returns max number of people
	}

	public void setMaxPax(Integer maxPax) {
		this.maxPax = maxPax; // Sets max number of people
	}

	public Integer getAvailableSlots() {
		return availableSlots; // Returns available slots
	}

	public void setAvailableSlots(Integer availableSlots) {
		this.availableSlots = availableSlots; // Sets available slots
	}
}