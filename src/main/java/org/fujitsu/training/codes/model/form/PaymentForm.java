package org.fujitsu.training.codes.model.form;

public class PaymentForm {
	private Integer bookingId; // Stores booking ID
	private String cardName; // Stores card holder name
	private String cardNumber; // Stores card number
	private String paymentType; // Stores payment type
	private Double amount; // Stores payment amount
	
	public PaymentForm() {} // Default constructor

	public PaymentForm(Integer bookingId, String cardName, String cardNumber, String paymentType, Double amount) {
		super();
		this.bookingId = bookingId; // Initializes booking ID
		this.cardName = cardName; // Initializes card name
		this.cardNumber = cardNumber; // Initializes card number
		this.paymentType = paymentType; // Initializes payment type
		this.amount = amount; // Initializes amount
	}

	public Integer getBookingId() {
		return bookingId; // Returns booking ID
	}

	public void setBookingId(Integer bookingId) {
		this.bookingId = bookingId; // Sets booking ID
	}

	public String getCardName() {
		return cardName; // Returns card name
	}

	public void setCardName(String cardName) {
		this.cardName = cardName; // Sets card name
	}

	public String getCardNumber() {
		return cardNumber; // Returns card number
	}

	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber; // Sets card number
	}

	public String getPaymentType() {
		return paymentType; // Returns payment type
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType; // Sets payment type
	}

	public Double getAmount() {
		return amount; // Returns amount
	}

	public void setAmount(Double amount) {
		this.amount = amount; // Sets amount
	}
	
	
}