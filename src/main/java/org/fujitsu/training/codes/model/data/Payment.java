package org.fujitsu.training.codes.model.data;

import java.time.LocalDateTime;

public class Payment {
	private Integer paymentId;
	private Integer bookingId;
	private String cardName;
	private String cardNumber;
	private String paymentType;
	private Double amount;
	private LocalDateTime paymentDate;
	private String status;
	
	public Payment() {}

	public Payment(Integer paymentId, Integer bookingId, String cardName, String cardNumber, String paymentType,
			Double amount, LocalDateTime paymentDate, String status) {
		super();
		this.paymentId = paymentId;
		this.bookingId = bookingId;
		this.cardName = cardName;
		this.cardNumber = cardNumber;
		this.paymentType = paymentType;
		this.amount = amount;
		this.paymentDate = paymentDate;
		this.status = status;
	}

	public Integer getPaymentId() {
		return paymentId;
	}

	public void setPaymentId(Integer paymentId) {
		this.paymentId = paymentId;
	}

	public Integer getBookingId() {
		return bookingId;
	}

	public void setBookingId(Integer bookingId) {
		this.bookingId = bookingId;
	}

	public String getCardName() {
		return cardName;
	}

	public void setCardName(String cardName) {
		this.cardName = cardName;
	}

	public String getCardNumber() {
		return cardNumber;
	}

	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}

	public String getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public LocalDateTime getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(LocalDateTime paymentDate) {
		this.paymentDate = paymentDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
