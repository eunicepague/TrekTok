package org.fujitsu.training.codes.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.fujitsu.training.codes.model.data.TourPackage;

public interface PackageMapper {

	@Select("""
			select p.package_id as packageId,
			       p.package_name as packageName,
			       p.destination,
			       p.description,
			       p.price,
			       p.duration,
			       p.image_name as imageName,
			       p.weather_info as weatherInfo,
			       p.latitude,
			       p.longitude,
			       p.package_type as packageType,
			       coalesce(sum(po.available_slots), 0) as availableSlots
			from packages p
			left join package_option po
			on p.package_id = po.package_id
			group by p.package_id, p.package_name, p.destination, p.description,
			         p.price, p.duration, p.image_name, p.weather_info, p.latitude, p.longitude, p.package_type
			order by p.package_id
			""")
	public List<TourPackage> selectAllPackages();

	@Select("""
			select p.package_id as packageId,
			       p.package_name as packageName,
			       p.destination,
			       p.description,
			       p.price,
			       p.duration,
			       p.image_name as imageName,
			       p.weather_info as weatherInfo,
			       p.latitude,
			       p.longitude,
			       p.package_type as packageType,
			       coalesce(sum(po.available_slots), 0) as availableSlots
			from packages p
			left join package_option po
			on p.package_id = po.package_id
			where p.package_id = #{packageId}
			group by p.package_id, p.package_name, p.destination, p.description,
			         p.price, p.duration, p.image_name, p.weather_info, p.latitude, p.longitude, p.package_type
			""")
	public TourPackage selectPackageById(@Param("packageId") Integer packageId);
	
	@Update("""
			update packages
			set available_slots = available_slots - #{travelerCount}
			where package_id = #{packageId} and available_slots >= #{travelerCount}
			""")
	public Integer decreaseAvailableSlots(@Param("packageId") Integer packageId,
			@Param("travelerCount") Integer travelerCount);

	@Insert("""
			insert into packages(package_name, destination, description, price, duration, image_name, available_slots, weather_info, latitude, longitude, package_type)
			values(#{packageName}, #{destination}, #{description}, #{price}, #{duration}, #{imageName}, #{availableSlots}, #{weatherInfo}, #{latitude}, #{longitude}, #{packageType})
			""")
	public Integer insertPackage(TourPackage rec);
	
	@Update("""
			update packages
			set package_name = #{packageName},
			    destination = #{destination},
			    description = #{description},
			    price = #{price},
			    duration = #{duration},
			    image_name = #{imageName},
			    available_slots = #{availableSlots},
			    weather_info = #{weatherInfo},
			    latitude = #{latitude},
			    longitude = #{longitude},
			    package_type = #{packageType}
			where package_id = #{packageId}
			""")
	public Integer updatePackage(TourPackage rec);

	@Delete("""
			delete from packages
			where package_id = #{packageId}
			""")
	public Integer deletePackage(@Param("packageId") Integer packageId);

	
	@Select("""
			select p.package_id as packageId,
			       p.package_name as packageName,
			       p.destination,
			       p.description,
			       p.price,
			       p.duration,
			       p.image_name as imageName,
			       p.weather_info as weatherInfo,
			       p.latitude,
			       p.longitude,
			       p.package_type as packageType,
			       coalesce(sum(po.available_slots), 0) as availableSlots
			from packages p
			left join package_option po
			    on p.package_id = po.package_id
			where lower(p.package_name) like lower('%' || #{keyword} || '%')
			   or lower(p.destination) like lower('%' || #{keyword} || '%')
			group by p.package_id, p.package_name, p.destination, p.description,
			         p.price, p.duration, p.image_name, p.weather_info, p.latitude, p.longitude, p.package_type
			order by p.package_id
			""")
	public List<TourPackage> searchPackages(@Param("keyword") String keyword);

	@Select("""
			select p.package_id as packageId,
			       p.package_name as packageName,
			       p.destination,
			       p.description,
			       p.price,
			       p.duration,
			       p.image_name as imageName,
			       p.weather_info as weatherInfo,
			       p.latitude,
			       p.longitude,
			       p.package_type as packageType,
			       coalesce(sum(po.available_slots), 0) as availableSlots
			from packages p
			left join package_option po
			on p.package_id = po.package_id
			where p.package_type = #{packageType}
			group by p.package_id, p.package_name, p.destination, p.description,
			         p.price, p.duration, p.image_name, p.weather_info, p.latitude, p.longitude, p.package_type
			order by p.package_id
			""")
	public List<TourPackage> selectPackagesByType(@Param("packageType") String packageType);

	
	// for pagination
	@Select("""
			select p.package_id as packageId,
			       p.package_name as packageName,
			       p.destination,
			       p.description,
			       p.price,
			       p.duration,
			       p.image_name as imageName,
			       p.weather_info as weatherInfo,
			       p.latitude,
			       p.longitude,
			       p.package_type as packageType,
			       coalesce(sum(po.available_slots), 0) as availableSlots
			from packages p
			left join package_option po
			on p.package_id = po.package_id
			group by p.package_id, p.package_name, p.destination, p.description,
			         p.price, p.duration, p.image_name, p.weather_info, p.latitude, p.longitude, p.package_type
			order by p.package_id
			limit #{limit} offset #{offset}
			""")
	public List<TourPackage> selectPackagesPage(@Param("limit") Integer limit,
			@Param("offset") Integer offset);

	@Select("""
			select count(*)
			from packages
			""")
	public Integer countAllPackages();
}