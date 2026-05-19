package org.fujitsu.training.codes.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.fujitsu.training.codes.model.data.Booking;

public interface BookingMapper {

	@Insert("""
			insert into bookings(user_id, package_id, option_id, comments, travel_date, status)
			values(#{userId}, #{packageId}, #{optionId}, #{comments}, #{travelDate}::date, 'PENDING')
			""")
	public Integer insertBooking(@Param("userId") Integer userId,
			@Param("packageId") Integer packageId,
			@Param("optionId") Integer optionId,
			@Param("comments") String comments,
			@Param("travelDate") String travelDate);

	@Select("""
			select b.booking_id as bookingId,
			       b.user_id as userId,
			       b.package_id as packageId,
			       b.booking_date as bookingDate,
			       b.comments,
			       b.status,
			       case
			           when p.payment_id is not null then 'PAID'
			           else 'NOT YET PAID'
			       end as paymentStatus,
			       pkg.package_name as packageName,
			       pkg.image_name as imageName,
			       b.travel_date as travelDate,
			       b.option_id as optionId,
			       po.option_name as optionName,
			       po.price as optionPrice
			from bookings b
			inner join packages pkg
			    on b.package_id = pkg.package_id
			inner join package_option po
			    on b.option_id = po.option_id
			left join payments p
			    on b.booking_id = p.booking_id
			where b.user_id = #{userId}
			order by b.booking_id desc
			""")
	public List<Booking> selectBookingsByUserId(@Param("userId") Integer userId);

	@Select("""
			select b.booking_id as bookingId,
			       b.user_id as userId,
			       b.package_id as packageId,
			       b.booking_date as bookingDate,
			       b.comments,
			       b.status,
			       case
			           when p.payment_id is not null then 'PAID'
			           else 'NOT YET PAID'
			       end as paymentStatus,
			       pkg.package_name as packageName,
			       pkg.image_name as imageName,
			       b.travel_date as travelDate,
			       b.option_id as optionId,
			       po.option_name as optionName,
			       po.price as optionPrice
			from bookings b
			inner join packages pkg
			    on b.package_id = pkg.package_id
			inner join package_option po
			    on b.option_id = po.option_id
			left join payments p
			    on b.booking_id = p.booking_id
			order by b.booking_id desc
			""")
	public List<Booking> selectAllBookings();

	@Select("""
			select b.booking_id as bookingId,
			       b.user_id as userId,
			       b.package_id as packageId,
			       b.booking_date as bookingDate,
			       b.comments,
			       b.status,
			       case
			           when p.payment_id is not null then 'PAID'
			           else 'NOT YET PAID'
			       end as paymentStatus,
			       pkg.package_name as packageName,
			       pkg.image_name as imageName,
			       b.travel_date as travelDate,
			       b.option_id as optionId,
			       po.option_name as optionName,
			       po.price as optionPrice
			from bookings b
			inner join packages pkg
			    on b.package_id = pkg.package_id
			inner join package_option po
			    on b.option_id = po.option_id
			left join payments p
			    on b.booking_id = p.booking_id
			where b.booking_id = #{bookingId}
			""")
	public Booking selectBookingById(@Param("bookingId") Integer bookingId);

	@Update("""
			update bookings
			set status = 'CANCELLED'
			where booking_id = #{bookingId}
			  and status in ('PENDING', 'CONFIRMED')
			""")
	public Integer cancelBooking(@Param("bookingId") Integer bookingId);

	@Update("""
			update bookings
			set status = #{status}
			where booking_id = #{bookingId}
			  and status = 'PENDING'
			""")
	public Integer updateBookingStatus(@Param("bookingId") Integer bookingId,
			@Param("status") String status);

	@Select("""
			select count(*)
			from bookings
			where option_id = #{optionId}
			""")
	public Integer countBookingsByOptionId(@Param("optionId") Integer optionId);

	@Select("""
			select b.booking_id as bookingId,
			       b.user_id as userId,
			       b.package_id as packageId,
			       b.booking_date as bookingDate,
			       b.comments,
			       b.status,
			       case
			           when p.payment_id is not null then 'PAID'
			           else 'NOT YET PAID'
			       end as paymentStatus,
			       pkg.package_name as packageName,
			       pkg.image_name as imageName,
			       b.travel_date as travelDate,
			       b.option_id as optionId,
			       po.option_name as optionName,
			       po.price as optionPrice
			from bookings b
			inner join packages pkg
			    on b.package_id = pkg.package_id
			inner join package_option po
			    on b.option_id = po.option_id
			left join payments p
			    on b.booking_id = p.booking_id
			order by b.booking_id desc
			limit #{limit} offset #{offset}
			""")
	public List<Booking> selectBookingsPage(@Param("limit") Integer limit,
			@Param("offset") Integer offset);

	@Select("""
			select count(*)
			from bookings
			""")
	public Integer countAllBookings();
}