package org.fujitsu.training.codes.service;

import java.util.Properties;

import org.springframework.stereotype.Service;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

@Service
public class EmailService {

	public boolean sendEmail(String toEmail, String subject, String body) {
		final String fromEmail = "cutepague@gmail.com";
		final String appPassword = "qeke jdfw ujsm culp";

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		Session session = Session.getInstance(props, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromEmail, appPassword);
			}
		});

		try {
			Message msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(fromEmail));
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
			msg.setSubject(subject);
			msg.setText(body);

			Transport.send(msg);
			System.out.println("EMAIL SUCCESSFULLY SENT TO: " + toEmail);
			return true;
		} catch (Exception e) {
			System.out.println("EMAIL SENDING FAILED");
			e.printStackTrace();
		}

		return false;
	}

	public boolean sendBookingStatusEmail(String toEmail, String firstName, String packageName,
			String optionName, Object travelDate, String status) {

		String safeName = firstName == null || firstName.trim().isEmpty() ? "Customer" : firstName.trim();
		String safePackageName = packageName == null || packageName.trim().isEmpty() ? "-" : packageName.trim();
		String safeOptionName = optionName == null || optionName.trim().isEmpty() ? "-" : optionName.trim();
		String safeTravelDate = travelDate == null ? "-" : travelDate.toString();
		String safeStatus = status == null ? "UPDATED" : status.trim().toUpperCase();

		String subject;
		String body;

		if ("CONFIRMED".equalsIgnoreCase(safeStatus)) {
			subject = "TrekTok Booking Confirmed";
			body = "Hello " + safeName + ",\n\n"
					+ "Good news! Your booking has been confirmed by TrekTok.\n\n"
					+ "Booking Details:\n"
					+ "Package: " + safePackageName + "\n"
					+ "Option: " + safeOptionName + "\n"
					+ "Travel Date: " + safeTravelDate + "\n"
					+ "Status: CONFIRMED\n\n"
					+ "You may now log in to your TrekTok account and proceed with payment.\n\n"
					+ "Thank you for choosing TrekTok.";
		} else if ("REJECTED".equalsIgnoreCase(safeStatus)) {
			subject = "TrekTok Booking Rejected";
			body = "Hello " + safeName + ",\n\n"
					+ "We regret to inform you that your booking has been rejected by TrekTok.\n\n"
					+ "Booking Details:\n"
					+ "Package: " + safePackageName + "\n"
					+ "Option: " + safeOptionName + "\n"
					+ "Travel Date: " + safeTravelDate + "\n"
					+ "Status: REJECTED\n\n"
					+ "You may create a new booking or choose another available package option.\n\n"
					+ "Thank you for your understanding.";
		} else {
			subject = "TrekTok Booking Status Update";
			body = "Hello " + safeName + ",\n\n"
					+ "Your booking status has been updated.\n\n"
					+ "Booking Details:\n"
					+ "Package: " + safePackageName + "\n"
					+ "Option: " + safeOptionName + "\n"
					+ "Travel Date: " + safeTravelDate + "\n"
					+ "Status: " + safeStatus + "\n\n"
					+ "Please log in to your TrekTok account for more details.\n\n"
					+ "Thank you for choosing TrekTok.";
		}

		return sendEmail(toEmail, subject, body);
	}

	public boolean sendPaymentReceiptEmail(String toEmail, String firstName, String packageName,
			String optionName, Object travelDate, Double amount, Object paymentDate, String paymentType,
			Integer bookingId) {

		String safeName = firstName == null || firstName.trim().isEmpty() ? "Customer" : firstName.trim();
		String safePackageName = packageName == null || packageName.trim().isEmpty() ? "-" : packageName.trim();
		String safeOptionName = optionName == null || optionName.trim().isEmpty() ? "-" : optionName.trim();
		String safeTravelDate = travelDate == null ? "-" : travelDate.toString();
		String safePaymentDate = paymentDate == null ? "-" : paymentDate.toString();
		String safePaymentType = paymentType == null || paymentType.trim().isEmpty() ? "-" : paymentType.trim();
		String safeAmount = amount == null ? "0.00" : String.format("%.2f", amount);
		String safeBookingId = bookingId == null ? "-" : bookingId.toString();

		String subject = "TrekTok Payment Receipt";
		String body = "Hello " + safeName + ",\n\n"
				+ "Thank you for your payment. Here is your receipt summary.\n\n"
				+ "Payment Details:\n"
				+ "Booking ID: " + safeBookingId + "\n"
				+ "Package: " + safePackageName + "\n"
				+ "Option: " + safeOptionName + "\n"
				+ "Travel Date: " + safeTravelDate + "\n"
				+ "Payment Type: " + safePaymentType + "\n"
				+ "Amount Paid: PHP " + safeAmount + "\n"
				+ "Payment Date: " + safePaymentDate + "\n"
				+ "Status: PAID\n\n"
				+ "Please keep this email as your payment receipt.\n\n"
				+ "Thank you for choosing TrekTok.";

		return sendEmail(toEmail, subject, body);
	}
}