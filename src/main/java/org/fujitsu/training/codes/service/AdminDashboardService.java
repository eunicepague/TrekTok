package org.fujitsu.training.codes.service;

import java.util.List;

import org.fujitsu.training.codes.dao.AdminDashboardMapper;
import org.fujitsu.training.codes.model.data.Booking;
import org.fujitsu.training.codes.model.data.Feedback;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminDashboardService {

	@Autowired
	private AdminDashboardMapper adminDashboardMapper;

	public Integer countUsers() {
		return adminDashboardMapper.countUsers();
	}

	public Integer countBookings() {
		return adminDashboardMapper.countBookings();
	}

	public Integer countPayments() {
		return adminDashboardMapper.countPayments();
	}

	public Integer countFeedback() {
		return adminDashboardMapper.countFeedback();
	}

	public Integer countPackages() {
		return adminDashboardMapper.countPackages();
	}

	public Integer countPackageOptions() {
		return adminDashboardMapper.countPackageOptions();
	}

	public List<Booking> selectRecentBookings() {
		return adminDashboardMapper.selectRecentBookings();
	}

	public List<Feedback> selectRecentFeedback() {
		return adminDashboardMapper.selectRecentFeedback();
	}
}