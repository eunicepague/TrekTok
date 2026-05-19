package org.fujitsu.training.codes.model.data;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Booking {
	private Integer bookingId;
	private Integer userId;
	private Integer packageId;
	private LocalDateTime bookingDate;
	private String comments;
	private String status;
	private String paymentStatus;
	private String packageName;
	private String imageName;
	private LocalDate travelDate;
	private Integer travelerCount;
	private Integer optionId;
	private String optionName;
	private Double optionPrice;
	
	public Booking() {}

	public Booking(Integer bookingId, Integer userId, Integer packageId, LocalDateTime bookingDate, String comments,
			String status, String paymentStatus, String packageName, String imageName, LocalDate travelDate,
			Integer travelerCount, Integer optionId, String optionName, Double optionPrice) {
		super();
		this.bookingId = bookingId;
		this.userId = userId;
		this.packageId = packageId;
		this.bookingDate = bookingDate;
		this.comments = comments;
		this.status = status;
		this.paymentStatus = paymentStatus;
		this.packageName = packageName;
		this.imageName = imageName;
		this.travelDate = travelDate;
		this.travelerCount = travelerCount;
		this.optionId = optionId;
		this.optionName = optionName;
		this.optionPrice = optionPrice;
	}

	public Integer getBookingId() {
		return bookingId;
	}

	public void setBookingId(Integer bookingId) {
		this.bookingId = bookingId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getPackageId() {
		return packageId;
	}

	public void setPackageId(Integer packageId) {
		this.packageId = packageId;
	}

	public LocalDateTime getBookingDate() {
		return bookingDate;
	}

	public void setBookingDate(LocalDateTime bookingDate) {
		this.bookingDate = bookingDate;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPaymentStatus() {
		return paymentStatus;
	}

	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}

	public String getPackageName() {
		return packageName;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}

	public String getImageName() {
		return imageName;
	}

	public void setImageName(String imageName) {
		this.imageName = imageName;
	}

	public LocalDate getTravelDate() {
		return travelDate;
	}

	public void setTravelDate(LocalDate travelDate) {
		this.travelDate = travelDate;
	}

	public Integer getTravelerCount() {
		return travelerCount;
	}

	public void setTravelerCount(Integer travelerCount) {
		this.travelerCount = travelerCount;
	}

	public Integer getOptionId() {
		return optionId;
	}

	public void setOptionId(Integer optionId) {
		this.optionId = optionId;
	}

	public String getOptionName() {
		return optionName;
	}

	public void setOptionName(String optionName) {
		this.optionName = optionName;
	}

	public Double getOptionPrice() {
		return optionPrice;
	}

	public void setOptionPrice(Double optionPrice) {
		this.optionPrice = optionPrice;
	}
}